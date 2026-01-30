//
//  HomeViewModel.swift
//  XWeather
//
//  Created by Evgenii Mikhailov on 24.12.2025.
//

import Foundation
import Combine
import SwiftUI

@MainActor
final class HomeViewModel: ObservableObject {
    
    @Published private(set) var state: LoadWeatherState = .idle
    @Published private(set) var weatherModel: WeatherScreenModel?
    
    private let loadWeatherUseCase: LoadWeatherUseCaseProtocol
    private var loadTask: Task<WeatherScreenModel, Error>?
    
    private var didInitialLoad = false
    
    
    
    init(loadWeatherUseCase: LoadWeatherUseCaseProtocol) {
        self.loadWeatherUseCase = loadWeatherUseCase
    }
    
    func loadWeather() async {
        await run(mode: .initial)
    }
    
    func refresh() async {
        await run(mode: .refresh)
    }
    
    func loadIfNeeded() async {
        guard !didInitialLoad else { return }
        didInitialLoad = true
        await loadWeather()
    }
    
    private enum Mode { case initial, refresh }
    
    private func run(mode: Mode) async {
        loadTask?.cancel()
        
        // 2) Выставляем state
        if mode == .initial || weatherModel == nil {
            state = .loading
        } else if let current = weatherModel {
            state = .updating(current) // без force unwrap
        }
        
        // 3) Стартуем задачу и ВАЖНО: ждём её .value
        let task = Task<WeatherScreenModel, Error> {
            try await loadWeatherUseCase.getWeather()
        }
        
        loadTask = task
        
        do {
            let model = try await task.value
            weatherModel = model
            state = .loaded(model)
            
        } catch is CancellationError {
            // Отменили — возвращаемся к текущей модели, если она есть
            if let current = weatherModel {
                state = .loaded(current)
            } else {
                state = .idle
            }
            
        } catch let error as LoadWeatherError {
            switch error {
            case .permissionDenied:
                state = .permissionDenied
                openSettings()
                
            default:
                // При refresh лучше не "ронять" экран, а оставить старые данные
                if let current = weatherModel {
                    state = .loaded(current)
                } else {
                    state = .failed(error.localizedDescription)
                }
            }
            
        } catch {
            if let current = weatherModel {
                state = .loaded(current)
            } else {
                state = .failed(error.localizedDescription)
            }
        }
    }
    
    private func openSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url)
    }
}
