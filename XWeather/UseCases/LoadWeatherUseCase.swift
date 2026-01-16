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
    private let weatherRepository: WeatherRepositoryProtocol
    private let geocoderService: GeocoderServiceProtocol
    
    init(locationRepo: LocationRepositoryProtocol,
         weatherRepo: WeatherRepositoryProtocol,
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
        async let weather = weatherRepository.fetchWeather(for: location)
        async let place = geocoderService.convert(from: location)
        return WeatherScreenModel(place: try await place, weather: try await weather)
    }
}
