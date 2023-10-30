//
//  Constants.swift
//  WeatherForecastApp
//
//  Created by Amali Krigger on 10/29/23.
//

import Foundation

struct Constants {
  static let currentWeatherDataBaseURL = "https://api.openweathermap.org/data/2.5/onecall"
  static let apiKey = URLQueryItem(name: "appid", value: "fad7be6d3efab6853151833dfe5b49c2")
  static let degreesType = URLQueryItem(name: "units", value: "imperial")
  static let exclude = URLQueryItem(name: "exclude", value: "alerts,minutely")
}
