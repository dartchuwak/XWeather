//
//  WeeklyForecastView.swift
//  XWeather
//
//  Created by Evgenii Mikhailov on 26.12.2025.
//

import SwiftUI

struct WeeklyForecastView: View {
    @Binding var path: NavigationPath
    let forecast: [DailyForecast]
    var body: some View {
            VStack(alignment: .leading, spacing: 4) {
                Text("Weakly forecast")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.bottom, 8)
                    .padding(.leading, 4)
                ForEach(forecast) { day in
                    Button {
                        path.append(Route.day(forecast: day))
                    } label: {
                        WeaklyForecastDayCell(forecast: day)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal)
        }
}
