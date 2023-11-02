//
//  CityWeatherForecastData.swift
//  WeatherForecastApp
//
//  Created by Amali Krigger on 11/1/23.
//

import Foundation

struct CityWeatherForecastData: Decodable {
  let coord: Coord
  let weather: [Weather]
  let base: String
  let main: Main
  let visibility: Double
  let wind: Wind
  let clouds: Clouds
  let dt: TimeInterval
  let sys: Sys
  let timezone: Double
  let id: Double
  let name: String
  let cod: Double
}

struct Coord: Decodable {
  let lon: Double
  let lat: Double
}

struct Weather: Decodable {
  let id: Double
  let main: String
  let description: String
  let icon: String
}

struct Main: Decodable {
  let temp: Double
  let feelsLike: Double
  let tempMin: Double
  let tempMax: Double
  let pressure: Double
  let humidity: Double
}

struct Wind: Decodable {
  let speed: Double
  let deg: Int
}

struct Clouds: Decodable {
  let all: Double
}

struct Sys: Decodable {
  let type: Double
  let id: Double
  let country: String
  let sunrise: Double
  let sunset: Double
}

extension CityWeatherForecastData {
  var currentDateTime: String? {
    let date = Date.dateFromUnixTimestamp(dt)
    let formattedDate = date.formattedWeekdayTime()
    return formattedDate
  }

  var formattedHumidity: String? {
    return String(main.humidity) + "%"
  }

  var formattedWind: String? {
    return String(format: "%.1f", wind.speed) + "km/h"
  }

  var formattedTemp: String? {
    return String(format: "%.0f", main.temp) + "°"
  }

  var formattedTempMin: String? {
    return String(format: "%.0f", main.tempMin) + "°"
  }

  var formattedTempMax: String? {
    return String(format: "%.0f", main.tempMax) + "°"
  }

}
