//
//  HourForecastView.swift
//  XWeather
//
//  Created by Evgenii Mikhailov on 27.12.2025.
//

import SwiftUI

struct HourForecastView: View {
    let hourForecasts: [HourForecast]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(hourForecasts) { forecast in
                    HourForecastCellView(forecast: forecast)
                }
            }
            .padding(.horizontal)
        }
    }
}
