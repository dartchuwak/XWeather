//
//  AppBuilder.swift
//  XWeather
//
//  Created by Evgenii Mikhailov on 26.12.2025.
//

import Foundation

final class AppBuilder {
    // MARK: - Services
    private lazy var locationService: LocationServiceProtocol = LocationService()
    private lazy var weatherKitService: WeatherKitServiceProtocol = WeatherKitService()
    private lazy var geocoder: GeocoderServiceProtocol = GeocoderService()
    
    // MARK: - Repository
    private lazy var weatherRepository: WeatherRepositoryProtocol =
    WeatherRepository(weatherKitservice: weatherKitService)
    
    private lazy var locationRepository: LocationRepositoryProtocol =
    LocationRepostitory(locationService: locationService)
    
    
    // MARK: - UseCase
    private lazy var loadWeatherUseCase: LoadWeatherUseCaseProtocol =
    LoadWeatherUseCase(locationRepo: locationRepository,
                       weatherRepo: weatherRepository,
                       geocoderService: geocoder)
    
    // MARK: - Factory
    func makeWeatherViewModel() -> HomeViewModel {
        HomeViewModel(loadWeatherUseCase: loadWeatherUseCase)
    }
}
