//
//  WeatherSnapshotMapping.swift
//  XWeather
//
//  Created by Evgenii Mikhailov on 19.01.2026.
//

import Foundation
import WeatherKit

protocol WeatherSnapshotMapping {
    func map(_ forecast: (current: CurrentWeather, daily: Forecast<DayWeather>, hourly: Forecast<HourWeather>)) -> WeatherSnapshot
}

struct WeatherSnapshotMapper: WeatherSnapshotMapping {
    
    private let tempFormatter: MeasurementFormatter
    private let dateFormatter: DateFormatter
    private let timeFormatter: DateFormatter
    private let dayFormatter: DateFormatter
    
    init(locale: Locale = .current, timeZone: TimeZone = .current) {
        let tf = MeasurementFormatter()
        tf.locale = locale
        tf.unitOptions = .providedUnit
        tf.unitStyle = .short
        
        let nf = NumberFormatter()
        nf.locale = locale
        nf.maximumFractionDigits = 0
        nf.minimumFractionDigits = 0
        nf.roundingMode = .halfUp
        tf.numberFormatter = nf
        self.tempFormatter = tf
        
        let dayFormatter = DateFormatter()
        dayFormatter.locale = locale
        dayFormatter.timeZone = timeZone
        dayFormatter.dateFormat = "EEEE"
        self.dayFormatter = dayFormatter
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.timeZone = timeZone
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        self.dateFormatter = dateFormatter
        
        let hf = DateFormatter()
        hf.locale = locale
        hf.timeZone = timeZone
        hf.dateStyle = .none
        hf.timeStyle = .short
        self.timeFormatter = hf
    }
    
    func map(_ forecast: (current: CurrentWeather, daily: Forecast<DayWeather>, hourly: Forecast<HourWeather>)) -> WeatherSnapshot {
        let current = CurrentForecast(
            temperature: formatCelsius(forecast.current.temperature),
            condition: forecast.current.condition.description,
            feelsLike: formatCelsius(forecast.current.apparentTemperature),
            icon: forecast.current.symbolName
        )
        
        let weekly: [DailyForecast] = forecast.daily.map { day in
            DailyForecast(
                          date: dateFormatter.string(from: day.date),
                          day: dayFormatter.string(from: day.date),
                          high: formatCelsius(day.highTemperature),
                          low: formatCelsius(day.lowTemperature),
                          sign: day.symbolName,
                          icon: day.symbolName,
                          percent: day.precipitation.description)
        }
        
        let hourly: [HourForecast] = forecast.hourly.map { hour in
            HourForecast(
                temperature: formatCelsius(hour.temperature),
                time: hour.date,
                icon: hour.symbolName
            )
        }
        
        return WeatherSnapshot(current: current, weakly: weekly, hour: hourly)
    }
    
    private func formatCelsius(_ measurement: Measurement<UnitTemperature>) -> String {
        let c = measurement.converted(to: .celsius)
        return tempFormatter.string(from: c)
    }
}
