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
    func fetchWeather(for location: CLLocation) async throws -> WeatherSnapshot
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
    
    func fetchWeather(for location: CLLocation) async throws -> WeatherSnapshot {
        let (dailyForecast, currentForecast, hourlyForecast) = try await service.weather(for: location, including: .daily, .current, .hourly)
        let weakly = Array(dailyForecast.forecast.prefix(7))
        let current = CurrentForecast(forecast: currentForecast)
        let daily = DailyForecast(forecast: dailyForecast.forecast.first!)
        let hourly = Array(hourlyForecast.forecast.filter { $0.date >= Date() }
            .prefix(13))
        let snapshot = WeatherSnapshot(current: current, daily: daily, weakly: weakly, hour: hourly)
        let cached = WidgetStore.CachedWeather(temperature: current.temperature, condition: current.condition, icon: current.icon, updatedAt: Date())
        WidgetStore.saveCachedWeather(cached)
        return snapshot
    }
}
