//
//  WeaklyForecastDayCell.swift
//  XWeather
//
//  Created by Evgenii Mikhailov on 26.12.2025.
//

import SwiftUI
import Charts

struct WeaklyForecastDayCell: View {
    let forecast: DailyForecast
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(forecast.date)
                    .foregroundStyle(Color.gray)
                    .font(.system(size: 12, weight: .regular))
                Text(forecast.day)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(forecast.day == "Воскресенье" || forecast.day == "Суббота" ? Color.orange : Color.white)
            }
           Spacer()
            
            HStack(alignment: .center, spacing: 20) {
                VStack {
                    Image(systemName: forecast.icon)
                        .frame(width: 20, height: 20)
                        .symbolVariant(.fill)
                        .symbolRenderingMode(.multicolor)
                    Text(forecast.percent)
                        .font(.system(size: 14, weight: .medium))
                }
                .layoutPriority(1)
                
                VStack {
                    Text("Day")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(Color.gray)
                    Text(forecast.high).monospacedDigit()
                        .font(.system(size: 14, weight: .medium))
                    
                }
                VStack {
                    Text("Night")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(Color.gray)
                    Text(forecast.low).monospacedDigit()
                        .font(.system(size: 14, weight: .medium))
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background {
            Color("cell")
        }
        .cornerRadius(15)
        
    }
}

#Preview {
    WeaklyForecastDayCell(forecast: DailyForecast(day: "Воскресенье", hight: "+4", low: "-1"))
        .padding(.horizontal)
}
