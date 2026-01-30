//
//  MainViewState.swift
//  XWeather
//
//  Created by Evgenii Mikhailov on 16.01.2026.
//

import Foundation

enum LoadWeatherState: Equatable {
    case idle
    case loading
    case updating(WeatherScreenModel)
    case loaded(WeatherScreenModel)
    case failed(String)
    case permissionDenied
}

extension LoadWeatherState {
    var isLoading: Bool {
        if case .loading = self { return true }
        return false
    }

    var isUpdating: Bool {
        if case .updating = self { return true }
        return false
    }
}
