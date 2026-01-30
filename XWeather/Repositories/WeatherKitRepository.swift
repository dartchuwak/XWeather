//
//  WeaterRepository.swift
//  XWeather
//
//  Created by Evgenii Mikhailov on 26.12.2025.
//

import Foundation
import CoreLocation
import WeatherKit

protocol WeatherKitRepositoryProtocol: Sendable {
    func fetchWeather(for location: CLLocation) async throws -> WeatherSnapshot
    func fetchHistoryWeather(for url: String) async throws -> OpenMeteoArchiveResponse
}

final class WeatherKitRepository: WeatherKitRepositoryProtocol {
    
    private let weatherKitservice: WeatherKitServiceProtocol
    private let network: NetworkService
    private let mapper: WeatherSnapshotMapping
    
    init(weatherKitservice: WeatherKitServiceProtocol,
         network: NetworkService = NetworkService(),
         mapper: WeatherSnapshotMapping = WeatherSnapshotMapper())
    {
        self.weatherKitservice = weatherKitservice
        self.network = NetworkService()
        self.mapper = WeatherSnapshotMapper()
    }
    
    func fetchWeather(for location: CLLocation) async throws -> WeatherSnapshot {
        let forecast = try await weatherKitservice.fetchWeather(for: location)
        let snapshot = mapper.map(forecast)
        return snapshot
    }
    
    func fetchHistoryWeather(for url: String) async throws -> OpenMeteoArchiveResponse {
        let response: OpenMeteoArchiveResponse = try await network.fetchData(url: url)
        return response
    }
}
