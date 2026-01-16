//
//  LoadWeatherError.swift
//  XWeather
//
//  Created by Evgenii Mikhailov on 16.01.2026.
//

import Foundation

enum LoadWeatherError: Error {
    case permissionDenied
    case locationFailed(Error)
    case network(Error)
    case unknown(Error)
}
