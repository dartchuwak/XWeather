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
        switch viewModel.state {
        case .idle, .loading:
            ProgressView()
                .task {
                   await viewModel.loadWeather()
                }
        case .loaded(let model), .updating( let model):
            NavigationStack(path: $path) {
                VStack(alignment: .leading) {
                    ScrollView( showsIndicators: false) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(model.place)
                                    .font(.title)
                                Text("Feels like \(model.weather.current.feelsLike)")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.cyan)
                                Text(model.weather.daily.date)
                                HStack {
                                    Text(model.weather.current.temperature)
                                        .fontWeight(.bold)
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
                        
                        
                            HourForecastView(hourForecasts: model.weather.hour)
                        
                        
                        WeeklyForecastView(path: $path, forecast: model.weather.weakly)
                    }
                }
                .background {
                    Image("bg")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                }
                .refreshable {
                    await viewModel.refresh()
                }
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .day(let forecast):
                        DayForecastView(forecast: forecast)
                    case .settings:
                        EmptyView()
                    case .home:
                        EmptyView()
                    }
                    
                }
            }
        default:
            Text("Default")
        }
        
    }
}

#Preview {
    let vm = AppBuilder().makeWeatherViewModel()
    HomeView(viewModel: vm)
        .foregroundStyle(.white)
}
