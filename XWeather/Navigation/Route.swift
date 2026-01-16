//
//  Route.swift
//  XWeather
//
//  Created by Evgenii Mikhailov on 30.12.2025.
//

import Foundation

enum Route: Hashable {
    case day(DailyForecast)
    case settings
    case home
}
