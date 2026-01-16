//
//  WeatherHelper.swift
//  XWeather
//
//  Created by Evgenii Mikhailov on 27.12.2025.
//

import Foundation
import WeatherKit

extension WeatherCondition {
    var uiString: String {
        switch self {
        case .clear:                 return String(localized: "weather.clear", defaultValue: "Clear")
        case .cloudy:                return String(localized: "weather.cloudy", defaultValue: "Cloudy")
        case .mostlyClear:           return String(localized: "weather.mostlyClear", defaultValue: "Mostly clear")
        case .partlyCloudy:          return String(localized: "weather.partlyCloudy", defaultValue: "Partly cloudy")
        case .mostlyCloudy:          return String(localized: "weather.mostlyCloudy", defaultValue: "Mostly cloudy")
        case .rain:                  return String(localized: "weather.rain", defaultValue: "Rain")
        case .heavyRain:             return String(localized: "weather.heavyRain", defaultValue: "Heavy rain")
        case .drizzle:               return String(localized: "weather.drizzle", defaultValue: "Drizzle")
        case .freezingRain:          return String(localized: "weather.freezingRain", defaultValue: "Freezing rain")
        case .freezingDrizzle:       return String(localized: "weather.freezingDrizzle", defaultValue: "Freezing drizzle")
        case .snow:                  return String(localized: "weather.snow", defaultValue: "Snow")
        case .heavySnow:             return String(localized: "weather.heavySnow", defaultValue: "Heavy snow")
        case .flurries:              return String(localized: "weather.flurries", defaultValue: "Flurries")
        case .blowingSnow:           return String(localized: "weather.blowingSnow", defaultValue: "Blowing snow")
        case .blizzard:              return String(localized: "weather.blizzard", defaultValue: "Blizzard")
        case .thunderstorms:         return String(localized: "weather.thunderstorms", defaultValue: "Thunderstorms")
        case .isolatedThunderstorms: return String(localized: "weather.isolatedThunderstorms", defaultValue: "Isolated thunderstorms")
        case .scatteredThunderstorms:return String(localized: "weather.scatteredThunderstorms", defaultValue: "Scattered thunderstorms")
        case .strongStorms:          return String(localized: "weather.strongStorms", defaultValue: "Strong storms")
        case .foggy:                 return String(localized: "weather.foggy", defaultValue: "Fog")
        case .haze:                  return String(localized: "weather.haze", defaultValue: "Haze")
        case .smoky:                 return String(localized: "weather.smoky", defaultValue: "Smoke")
        case .windy:                 return String(localized: "weather.windy", defaultValue: "Windy")
        case .breezy:                return String(localized: "weather.breezy", defaultValue: "Breezy")
        case .sleet:                 return String(localized: "weather.sleet", defaultValue: "Sleet")
        case .wintryMix:             return String(localized: "weather.wintryMix", defaultValue: "Wintry mix")
        case .hail:                  return String(localized: "weather.hail", defaultValue: "Hail")
        case .tropicalStorm:         return String(localized: "weather.tropicalStorm", defaultValue: "Tropical storm")
        case .hurricane:             return String(localized: "weather.hurricane", defaultValue: "Hurricane")
        case .hot:                   return String(localized: "weather.hot", defaultValue: "Hot")
        case .frigid:                return String(localized: "weather.frigid", defaultValue: "Frigid")
        case .blowingDust:           return String(localized: "weather.blowingDust", defaultValue: "Blowing dust")
        case .sunShowers:            return String(localized: "weather.sunShowers", defaultValue: "Sun showers")
        case .sunFlurries:           return String(localized: "weather.sunFlurries", defaultValue: "Sun flurries")
        @unknown default:            return self.description
        }
    }
}
