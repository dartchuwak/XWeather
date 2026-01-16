//
//  LocationRepostitory.swift
//  XWeather
//
//  Created by Evgenii Mikhailov on 26.12.2025.
//

import Foundation
import CoreLocation

protocol LocationRepositoryProtocol {
    func requestPermission()
    func requestOneShotLocation() async throws -> CLLocation
}

final class LocationRepostitory: LocationRepositoryProtocol {
    
    private let locationService: LocationServiceProtocol
    
    
    init(locationService: LocationServiceProtocol) {
        self.locationService = locationService
    }
    
    func requestPermission() {
        locationService.requestPermission()
    }
    
    func requestOneShotLocation() async throws -> CLLocation {
       try await locationService.requestLocation()
    }
    
    
}
