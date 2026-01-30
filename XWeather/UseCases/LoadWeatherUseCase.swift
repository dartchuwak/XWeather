//
//  RequestLocationUseCase.swift
//  XWeather
//
//  Created by Evgenii Mikhailov on 26.12.2025.
//

import Foundation
import CoreLocation

protocol LoadWeatherUseCaseProtocol {
    func getWeather() async throws -> WeatherScreenModel
}

final class LoadWeatherUseCase: LoadWeatherUseCaseProtocol {
    
    private let locationRepository: LocationRepositoryProtocol
    private let weatherRepository: WeatherKitRepositoryProtocol
    private let geocoderService: GeocoderServiceProtocol
    
    init(locationRepo: LocationRepositoryProtocol,
         weatherRepo: WeatherKitRepositoryProtocol,
         geocoderService: GeocoderServiceProtocol) {
        self.locationRepository = locationRepo
        self.weatherRepository = weatherRepo
        self.geocoderService = geocoderService
    }
    
    func requestPermission() {
        locationRepository.requestPermission()
    }
    
    func getWeather() async throws -> WeatherScreenModel {
        let location = try await locationRepository.requestOneShotLocation()
        let snapshot = try await weatherRepository.fetchWeather(for: location)
        let place = try await geocoderService.convert(from: location)
        
        let filtered = WeatherSnapshot(
            current: snapshot.current,
            weakly: Array(snapshot.weakly.prefix(7)),
            hour: Array(snapshot.hour.filter{ $0.time >= Date()}.prefix(25))
        )
        
        let screenModel = WeatherScreenModel(place: place, weather: filtered)
        return screenModel
    }
}
