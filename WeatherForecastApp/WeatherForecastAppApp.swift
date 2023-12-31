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
      WeatherForecastView()
        .environmentObject(Coordinator())
        .environmentObject(WeatherForecastViewModel(networkManager: NetworkManager()))
        .environmentObject(SearchWeatherForecastViewModel(networkManager: NetworkManager()))
    }
  }
}
