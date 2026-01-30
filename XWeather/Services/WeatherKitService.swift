//
//  WeaterService.swift
//  XWeather
//
//  Created by Evgenii Mikhailov on 26.12.2025.
//

import Foundation
import CoreLocation
import WeatherKit

protocol WeatherKitServiceProtocol {
    func fetchWeather(for location: CLLocation) async throws -> (current: CurrentWeather, daily: Forecast<DayWeather>, hourly: Forecast<HourWeather>)
}

final class WeatherKitService: WeatherKitServiceProtocol {
    private let service: WeatherService
    init(service: WeatherService = .shared) {
        self.service = service
    }
    
    func fetchCurrentWeather(for location: CLLocation) async -> CurrentWeather? {
        guard let current = try? await service.weather(for: location, including: .current) else { return nil}
        return current
    }
    
    func fetchWeather(for location: CLLocation) async throws -> (current: CurrentWeather, daily: Forecast<DayWeather>, hourly: Forecast<HourWeather>) {
        try await service.weather(for: location, including: .current, .daily, .hourly)
    }
}
