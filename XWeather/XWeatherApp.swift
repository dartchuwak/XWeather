//
//  XWeatherApp.swift
//  XWeather
//
//  Created by Evgenii Mikhailov on 24.12.2025.
//

import SwiftUI

@main
struct XWeatherApp: App {
    private let appBuilder = AppBuilder()
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: appBuilder.makeWeatherViewModel())
                .foregroundStyle(.white)
        }
    }
}
