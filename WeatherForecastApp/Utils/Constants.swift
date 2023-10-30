//
//  Constants.swift
//  WeatherForecastApp
//
//  Created by Amali Krigger on 10/29/23.
//

import Foundation

struct Constants {
  static let baseURL = "https://api.openweathermap.org/data/2.5/weather"
  static let apiKey = URLQueryItem(name: "appid", value: "ff902a941caba2efc75c211425bd10fe")
  static let degreesType = URLQueryItem(name: "units", value: "imperial")
}
