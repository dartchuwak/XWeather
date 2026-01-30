//
//  WeatherSnapshot.swift
//  XWeather
//
//  Created by Evgenii Mikhailov on 26.12.2025.
//

import Foundation

struct WeatherScreenModel: Equatable {
    let place: String
    let weather: WeatherSnapshot
}

struct WeatherSnapshot: Equatable {
    let current: CurrentForecast
    let weakly: [DailyForecast]
    let hour: [HourForecast]
}

struct DailyForecast: Equatable, Hashable, Identifiable {
    let date: String
    let day: String
    let high: String
    let low: String
    let sign: String
    let icon: String
    let percent: String
    
    var id: Self { self }
}

struct CurrentForecast: Equatable {
    let temperature: String
    let condition: String
    let feelsLike: String
    let icon: String
}

struct HourForecast: Equatable, Hashable, Identifiable {
    let temperature: String
    let time: Date
    let icon: String
    
    var id: Self { self }
}

extension HourForecast {
    static let timeFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "HH:mm"
        f.locale = .current
        f.timeZone = .current
        return f
    }()

    var timeString: String {
        Self.timeFormatter.string(from: time)
    }
}
