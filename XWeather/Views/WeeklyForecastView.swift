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
        if forecast.isEmpty{
            EmptyView()
        } else {
            VStack(alignment: .leading, spacing: 4) {
                Text("Weakly forecast")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.bottom, 8)
                    .padding(.leading, 4)
                ForEach(forecast) { forecast in
                    Button {
                        path.append(forecast)
                    } label: {
                        WeaklyForecastDayCell(forecast: forecast)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

//#Preview {
//    WeeklyForecastView(forecast: [DailyForecast(day: "Понедельник", hight: "3", low: "-3"),
//                                  DailyForecast(day: "Вторник", hight: "3", low: "-3"),
//                                  DailyForecast(day: "Среда", hight: "3", low: "-3"),
//                                  DailyForecast(day: "Четверг", hight: "3", low: "-3"),
//                                  DailyForecast(day: "Пятница", hight: "3", low: "-3"),
//                                  DailyForecast(day: "Суббота", hight: "3", low: "-3"),
//                                  DailyForecast(day: "Воскресение", hight: "3", low: "-3")])
//}
