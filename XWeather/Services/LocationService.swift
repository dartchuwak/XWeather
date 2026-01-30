//
//  LocationService.swift
//  XWeather
//
//  Created by Evgenii Mikhailov on 24.12.2025.
//

import CoreLocation
import MapKit

protocol LocationServiceProtocol {
    func requestPermission()
    func requestLocation() async throws -> CLLocation
    func searchLocation()
}

final class LocationService: NSObject, LocationServiceProtocol {
    private let manager = CLLocationManager()
    private var continuation: CheckedContinuation<CLLocation, Error>?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
    }
    
    func requestPermission() {
        manager.requestWhenInUseAuthorization()
    }
    
    func searchLocation() {
    
    }
    
    func requestLocation() async throws -> CLLocation {
        let status = manager.authorizationStatus
        switch status {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            print("")
        case .authorizedWhenInUse, .authorizedAlways:
            break
        @unknown default:
            fatalError()
        }
        
        return try await withCheckedThrowingContinuation { cont in
            self.continuation?.resume(throwing: CancellationError())
            self.continuation = cont
            self.manager.requestLocation()
        }
    }
}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        continuation?.resume(returning: location)
        continuation = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        continuation?.resume(throwing: error)
        continuation = nil
    }
}
