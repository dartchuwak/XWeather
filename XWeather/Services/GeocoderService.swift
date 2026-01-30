//
//  GeocoderService.swift
//  XWeather
//
//  Created by Evgenii Mikhailov on 26.12.2025.
//

import Foundation
import CoreLocation

protocol GeocoderServiceProtocol: Sendable {
    func convert(from location: CLLocation) async throws -> String
    func convert(from place: String) async throws -> CLLocationCoordinate2D?
}

struct GeocoderService: GeocoderServiceProtocol {
    
    private let coder = CLGeocoder()
    
    func convert(from location: CLLocation) async throws -> String {
        let placemark = try await coder.reverseGeocodeLocation(location)
        let place = placemark.first
        let city = place?.administrativeArea ?? "Unknown City"
        WidgetStore.savePlace(name: city, lat: location.coordinate.latitude, lon: location.coordinate.longitude)
        return city
    }
    
    func convert(from place: String) async throws -> CLLocationCoordinate2D? {
        let request = try await coder.geocodeAddressString(place, in: nil)
        let location = request.first?.location
        return location?.coordinate
    }
}
