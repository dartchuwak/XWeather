//
//  ContentView.swift
//  XWeather
//
//  Created by Evgenii Mikhailov on 24.12.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    @State private var path = NavigationPath()
    
    init(viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                VStack {
                    content
                    // Полноэкранный лоадер только когда нет данных
                    
                    if viewModel.weatherModel == nil,
                       (viewModel.state == .idle || viewModel.state.isLoading) {
                        ProgressView()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background (Image("bg").resizable().scaledToFill().ignoresSafeArea())
            .refreshable {
                await viewModel.refresh()
            }
            .task {
                 await viewModel.loadIfNeeded()
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .day(let forecast):
                    DayForecastView(forecast: forecast)
                }
            }
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loaded(let model), .updating(let model):
            VStack(alignment: .leading) {
                ScrollView(showsIndicators: false) {
                    header(model: model)
                    HourForecastView(hourForecasts: model.weather.hour)
                    WeeklyForecastView(path: $path, forecast: model.weather.weakly)
                }
            }
            
        case .failed(let message):
            VStack {
                Text(message)
                Text("!!!")
            }
            
        case .permissionDenied:
            Text("Нет доступа к геолокации")
            
        case .idle, .loading:
           LottieLoaderView()
        }
    }
    
    private func header(model: WeatherScreenModel) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(model.place).font(.title)
                Text("Feels like \(model.weather.current.feelsLike)")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.cyan)
                
                Text(model.weather.weakly.first?.day.uppercased() ?? "?")
                
                HStack {
                    Text(model.weather.current.temperature).fontWeight(.bold)
                    Image(systemName: model.weather.current.icon)
                        .symbolVariant(.fill)
                        .fontWeight(.bold)
                        .symbolRenderingMode(.multicolor)
                }
                .font(.system(size: 72))
                
                Text(model.weather.current.condition)
                    .font(.title)
                    .fontWeight(.semibold)
            }
            .padding()
            Spacer()
        }
    }
}

#Preview {
    let vm = AppBuilder().makeWeatherViewModel()
    HomeView(viewModel: vm)
        .foregroundStyle(.white)
}
