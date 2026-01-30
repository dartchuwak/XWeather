//
//  OpenMeteoResponse.swift
//  XWeather
//
//  Created by Evgenii Mikhailov on 17.01.2026.
//

import Foundation

import Foundation

// Define the model for the response
struct OpenMeteoArchiveResponse: Codable {
    let latitude: Double
    let longitude: Double
    let timezone: String
    let timezoneAbbreviation: String
    let dailyUnits: DailyUnits
    let daily: Daily

    // Define custom keys for decoding (for snake_case or different key naming)
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case timezone
        case timezoneAbbreviation = "timezone_abbreviation"
        case dailyUnits = "daily_units"
        case daily
    }
}

struct DailyUnits: Codable {
    let time: String
    let temperature2mMin: String
    let temperature2mMax: String
    
    enum CodingKeys: String, CodingKey {
        case time
        case temperature2mMin = "temperature_2m_min"
        case temperature2mMax = "temperature_2m_max"
    }
}

struct Daily: Codable {
    let time: [String]
    let temperature2mMin: [Double]
    let temperature2mMax: [Double]
    
    enum CodingKeys: String, CodingKey {
        case time
        case temperature2mMin = "temperature_2m_min"
        case temperature2mMax = "temperature_2m_max"
    }
}
