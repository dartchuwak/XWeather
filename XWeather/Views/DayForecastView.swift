//
//  DayForecastView.swift
//  XWeather
//
//  Created by Evgenii Mikhailov on 30.12.2025.
//

import Foundation
import SwiftUI

struct DayForecastView: View {
    let forecast: DailyForecast
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(forecast.day)
                    .font(.largeTitle)
                    .bold()
                Text(forecast.high)
                    .foregroundStyle(.blue)
            }
            .padding(.top, 50)
        }
        .frame(maxWidth: .infinity)
        .background(.gray)
        .ignoresSafeArea(.all)
    }
}

//#Preview {
//    DayForecastView(forecast: DailyForecast(day: "Вторник", high: "-3", low: "-4"))
//}
