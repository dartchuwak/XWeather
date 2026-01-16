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
        VStack(alignment: .leading) {
            Text(forecast.day)
                .font(.largeTitle)
                .bold()
            Text(forecast.high)
        }
    }
}

#Preview {
    DayForecastView(forecast: DailyForecast(day: "Вторник", hight: "-3", low: "-4"))
}
