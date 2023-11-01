//
//  WeatherForecastAppApp.swift
//  WeatherForecastApp
//
//  Created by Amali Krigger on 10/27/23.
//

import SwiftUI

@main
struct WeatherForecastAppApp: App {
    var body: some Scene {
        WindowGroup {
            CurrentWeatherView()
            .environmentObject(Coordinator())
            .environmentObject(CurrentWeatherViewModel(networkManager: NetworkManager()))
        }
    }
}
