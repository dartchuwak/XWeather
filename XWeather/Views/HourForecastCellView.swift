//
//  HourForecastCellView.swift
//  XWeather
//
//  Created by Evgenii Mikhailov on 27.12.2025.
//

import SwiftUI

struct HourForecastCellView: View {
    let forecast: HourForecast
    var body: some View {
        VStack {
            Image(systemName: forecast.icon)
                .font(.title)
                .symbolVariant(.fill)
                .symbolRenderingMode(.multicolor)
            Text(forecast.timeString)
                .font(.subheadline)
            Text(forecast.temperature)
                .font(.title3)
                .fontWeight(.semibold)
        }
        .padding()
        .background(Color("cell"))
        .cornerRadius(15)
    }
}
