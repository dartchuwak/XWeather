//
//  WeaterRepository.swift
//  XWeather
//
//  Created by Evgenii Mikhailov on 26.12.2025.
//

import Foundation
import CoreLocation

protocol WeatherRepositoryProtocol {
    func fetchWeather(for location: CLLocation) async throws -> WeatherSnapshot
}

final class WeatherRepository: WeatherRepositoryProtocol {
    
    private let weatherKitservice: WeatherKitServiceProtocol
    
    init(weatherKitservice: WeatherKitServiceProtocol) {
        self.weatherKitservice = weatherKitservice
    }
    func fetchWeather(for location: CLLocation) async throws -> WeatherSnapshot {
        try await weatherKitservice.fetchWeather(for: location)
    }
}
