//
//  Coordinator.swift
//  WeatherForecastApp
//
//  Created by Amali Krigger on 10/29/23.
//

import Foundation
import SwiftUI

enum Page: Hashable {
  case dailyWeatherForecast
  case searchCityWeatherForecast
  case cityWeatherForecast
  case weatherForecast
}
class Coordinator: ObservableObject {
  @Published var path = NavigationPath()
  func showWeatherForecast() {
    path.append(Page.weatherForecast)
  }
  func showDailyWeatherForecast() {
    path.append(Page.dailyWeatherForecast)
  }
  func showSearchCityWeatherForecast() {
    path.append(Page.searchCityWeatherForecast)
  }
  func showCityWeatherForecast() {
    path.append(Page.cityWeatherForecast)
  }
}
