//
//  WidgetStore.swift
//  XWeather
//
//  Created by Evgenii Mikhailov on 27.12.2025.
//

import Foundation
import WidgetKit

enum WidgetStore {
    static let suite = UserDefaults(suiteName: "group.com.fishcode.XWeather")!
    
    // выбранный город
    static let placeNameLey = "place.name"
    static let placeLatKey  = "place.lat"
    static let placeLonKey  = "place.lon"
    
    static let cachedWeatherKey = "widget.cachedWeather"
    
    struct CachedWeather: Codable {
        let temperature: String
        let condition: String
        let icon: String
        let updatedAt: Date
    }
    
    static func loadPlace() -> (name: String, lat: Double, lon: Double)? {
        guard let name = suite.string(forKey: placeNameLey),
              let lat = suite.double(forKey: placeLatKey) as Double?,
              let lon = suite.double(forKey: placeLonKey) as Double? else {
            return nil
        }
        return (name, lat, lon)
    }
    
    static func loadCachedWeather() -> CachedWeather? {
        guard let data = suite.data(forKey: cachedWeatherKey) else { return nil }
        return try? JSONDecoder().decode(CachedWeather.self, from: data)
    }
    
    static func saveCachedWeather(_ value: CachedWeather) {
        if let data = try? JSONEncoder().encode(value) {
            suite.set(data, forKey: cachedWeatherKey)
            WidgetCenter.shared.reloadAllTimelines()
        }
        
    }
    
    static func savePlace(name: String, lat: Double, lon: Double) {
        suite.set(name, forKey: placeNameLey)
        suite.set(lat, forKey: placeLatKey)
        suite.set(lon, forKey: placeLonKey)
        WidgetCenter.shared.reloadAllTimelines()
    }
}
