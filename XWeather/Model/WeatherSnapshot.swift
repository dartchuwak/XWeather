//
//  WeatherSnapshot.swift
//  XWeather
//
//  Created by Evgenii Mikhailov on 26.12.2025.
//

import Foundation
import WeatherKit

struct WeatherScreenModel: Equatable {
    let place: String
    let weather: WeatherSnapshot
}

struct WeatherSnapshot: Equatable {
    let current: CurrentForecast
    let daily: DailyForecast
    let weakly: [DailyForecast]
    let hour: [HourForecast]
    
    init(current: CurrentForecast, daily: DailyForecast, weakly: [DayWeather], hour: [HourWeather]) {
        self.current = current
        self.daily = daily
        self.weakly = weakly.map {
            DailyForecast(forecast: $0)
        }
        self.hour = hour.map {
            HourForecast(forecast: $0)
        }
    }
}

struct DailyForecast: Equatable, Hashable, Identifiable {
    var id: Int
    let date: String
    let day: String
    let high: String
    let low: String
    let sign: String
    let icon: String
    let percent: String
    
    init(forecast: WeatherKit.DayWeather) {
        
        let dayKey = Int(forecast.date.timeIntervalSince1970 / 86_400)
        var hasher = Hasher()
        hasher.combine(dayKey)
        
        self.id = hasher.finalize()
        self.sign = "\u{00B0}"
        self.high = forecast.highTemperature.converted(to: .celsius).value
            .formatted(.number.precision(.fractionLength(0))) + sign
        
        self.low = forecast.lowTemperature.converted(to: .celsius).value
            .formatted(.number.precision(.fractionLength(0))) + sign
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.timeZone = .current
        formatter.dateFormat = "EEEE"
        
        self.day = formatter.string(from: forecast.date).capitalized
        self.icon = forecast.symbolName
        
        formatter.dateFormat = "dd MMMM"
        self.date = formatter.string(from: forecast.date).capitalized
        self.percent = forecast.precipitationChance.formatted(.percent).replacingOccurrences(of: " ", with: "\u{00A0}")
    }
    
    init(day: String, hight: String, low: String, id: Int = 123, date: String = "26 декабря", percent: String = "40%") {
        self.high = hight
        self.low = low
        self.date = date
        self.sign = ""
        self.icon = "cloud.fill"
        self.id = id
        self.day = day
        self.percent = percent
    }
}

struct CurrentForecast: Equatable {
    let temperature: String
    let condition: String
    let feelsLike: String
    let icon: String
    
    init(forecast: WeatherKit.CurrentWeather ) {
        let sign = forecast.temperature.unit.symbol
        self.temperature = forecast.temperature.converted(to: .celsius).value.formatted(.number.precision(.fractionLength(0))) + sign
        self.condition = forecast.condition.uiString
        self.feelsLike = forecast.apparentTemperature.converted(to: .celsius).value.formatted(.number.precision(.fractionLength(0))) + sign
        self.icon = forecast.symbolName
    }
}

struct HourForecast: Equatable, Identifiable {
    let id: Int
    let temperature: String
    let time: String
    let icon: String
    
    init(forecast: WeatherKit.HourWeather) {
        let dayKey = Int(forecast.date.timeIntervalSince1970)
        var hasher = Hasher()
        hasher.combine(dayKey)
        self.id = hasher.finalize()
        self.temperature = forecast.temperature.converted(to: .celsius).value.formatted(.number.precision(.fractionLength(0))) + "°"
        self.icon = forecast.symbolName
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.timeZone = .current
        formatter.dateFormat = "HH:mm"
        self.time = formatter.string(from: forecast.date)
    }
    
    init(id: Int = UUID().hashValue, temperature: String = "-1", time: String = "18:00", icon: String = "sun.max") {
        self.id = id
        self.temperature = temperature
        self.time = time
        self.icon = icon
    }
}
