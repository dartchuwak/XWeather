//
//  XWeatherWidget.swift
//  XWeatherWidget
//
//  Created by Evgenii Mikhailov on 27.12.2025.
//

import WidgetKit
import SwiftUI
import CoreLocation

struct Provider: TimelineProvider {
    
    func placeholder(in context: Context) -> WeatherEntry {
        WeatherEntry(date: .now, temp: "15", condition: "Sunny", icon: "sun.max", location: "Moscow")
    }
    
    func getSnapshot(in context: Context, completion: @escaping (WeatherEntry) -> ()) {
        if let cached = WidgetStore.loadCachedWeather() {
            completion(WeatherEntry(date: .now, temp: cached.temperature, condition: cached.condition, icon: cached.icon, location: "Moscow"))
        } else {
            completion(WeatherEntry(date: .now, temp: "15", condition: "Sunny", icon: "sun.max", location: "Moscow"))
        }
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            // 1) мгновенно — кэш
            let location = WidgetStore.loadPlace()
            let cachedWeather = WidgetStore.loadCachedWeather()
            let cachedEntry = WeatherEntry(
                date: .now,
                temp: cachedWeather?.temperature ?? "--°",
                condition: cachedWeather?.condition ?? "—",
                icon: cachedWeather?.icon ?? "",
                location: location?.name ?? ""
            )
            
            
            var entries: [WeatherEntry] = [cachedEntry]
            
            // 2) сеть (best-effort)
            if let place = WidgetStore.loadPlace(),
               let fresh = await fetchWeather(lat: place.lat, lon: place.lon, place: place.name) {
                
                // entry чуть позже "сейчас", чтобы был реальный апдейт
                let freshEntry = WeatherEntry(
                    date: Date().addingTimeInterval(5),
                    temp: fresh.temperature,
                    condition: fresh.condition,
                    icon: fresh.icon,
                    location: place.name
                )
                entries.append(freshEntry)
                
                // 3) обновить кэш
                let cachedWeather = WidgetStore.CachedWeather(temperature: fresh.temperature,
                                                              condition: fresh.condition,
                                                              icon: fresh.icon,
                                                              updatedAt: .now)
                WidgetStore.saveCachedWeather(cachedWeather)
            }
            
            let next = Date().addingTimeInterval(3600)
            completion(Timeline(entries: entries, policy: .after(next)))
        }
    }
    
    private func fetchWeather(lat: Double, lon: Double, place: String) async -> CurrentForecast? {
        let service = WeatherKitService()
        let location = CLLocation(latitude: lat, longitude: lon)
        guard let forecast = await service.fetchCurrentWeather(for: location) else { return nil }
        let currentForecast = CurrentForecast(temperature: "", condition: "", feelsLike: "", icon: "")
        return currentForecast
    }
}

struct WeatherEntry: TimelineEntry {
    let date: Date
    let temp: String
    let condition: String
    let icon: String
    let location: String
}

struct XWeatherWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(entry.location)
            HStack(alignment: .center) {
                Text(entry.temp).font(.system(size: 24, weight: .semibold))
                Image(systemName: entry.icon)
                    .symbolVariant(.fill)
                    .symbolRenderingMode(.multicolor)
            }
            Text(entry.condition)
                .font(.subheadline)
        }
    }
}

struct XWeatherWidget: Widget {
    let kind: String = "XWeatherWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
                XWeatherWidgetEntryView(entry: entry)
                    .containerBackground(Color("cell"), for: .widget)
          
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    XWeatherWidget()
} timeline: {
    WeatherEntry(date: .now, temp: "-3", condition: "Snow", icon: "sun.max", location: "Moscow")
}
