//
//  GeocoderService.swift
//  XWeather
//
//  Created by Evgenii Mikhailov on 26.12.2025.
//

import Foundation
import CoreLocation
import MapKit

protocol GeocoderServiceProtocol {
    func convert(from location: CLLocation) async throws -> String
}

final class GeocoderService: GeocoderServiceProtocol {
    
    private let coder = CLGeocoder()
    
    func convert(from location: CLLocation) async throws -> String {
        let placemark = try await coder.reverseGeocodeLocation(location)
        let place = placemark.first
        let city = place?.administrativeArea ?? "Unknown City"
        WidgetStore.savePlace(name: city, lat: location.coordinate.latitude, lon: location.coordinate.longitude)
        return city
    }
}
