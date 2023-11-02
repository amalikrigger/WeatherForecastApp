//
//  WeatherForecast.swift
//  WeatherForecastApp
//
//  Created by Amali Krigger on 10/29/23.
//

import Foundation

struct WeatherForecastData: Decodable {
  var lon: Double
  var lat: Double
  var timezone: String
  var timezoneOffset: Double
  var current: CurrentWeather
  var hourly: [HourlyWeather]
  var daily: [DailyWeather]
}

struct CurrentWeather: Decodable {
  let dt: TimeInterval
  let sunrise: TimeInterval
  let sunset: TimeInterval
  let temp: Double
  let feelsLike: Double
  let pressure: Double
  let humidity: Double
  let dewPoint: Double
  let uvi: Double
  let clouds: Double
  let visibility: Double
  let windSpeed: Double
  let windDeg: Double
  let weather: [WeatherInfo]
  let rain: RainInfo?
}

struct WeatherInfo: Decodable {
  let id: Double
  let main: String
  let description: String
  let icon: String
}

struct RainInfo: Decodable {
  let oneHour: Double
  enum CodingKeys: String, CodingKey {
    case oneHour = "1h"
  }

}

struct DailyWeather: Decodable {
  let dt: TimeInterval
  let sunrise: TimeInterval
  let sunset: TimeInterval
  let moonrise: TimeInterval
  let moonset: TimeInterval
  let moonPhase: Double
  let temp: Temperature
  let feelsLike: FeelsLike
  let pressure: Double
  let humidity: Double
  let dewPoint: Double
  let windSpeed: Double
  let windDeg: Double
  let windGust: Double
  let weather: [WeatherInfo]
  let clouds: Double
  let pop: Double
  let rain: Double?
  let uvi: Double
}

struct Temperature: Decodable {
  let day: Double
  let min: Double
  let max: Double
  let night: Double
  let eve: Double
  let morn: Double
}

struct FeelsLike: Decodable {
  let day: Double
  let night: Double
  let eve: Double
  let morn: Double
}

struct HourlyWeather: Decodable {
  let dt: TimeInterval
  let temp: Double
  let feelsLike: Double
  let pressure: Double
  let humidity: Double
  let dewPoint: Double
  let uvi: Double
  let clouds: Double
  let visibility: Double
  let windSpeed: Double
  let windDeg: Double
  let windGust: Double
  let weather: [WeatherInfo]
  let pop: Double
}

extension HourlyWeather {
  var hourlyTime: String? {
    let date = Date.dateFromUnixTimestamp(dt)
    let formattedDate = date.formattedTime()
    return formattedDate
  }

  var hourlyTemp: String? {
    return String(format: "%.0f", temp) + "°"
  }

}

extension DailyWeather {
  var dailyTime: String? {
    let date = Date.dateFromUnixTimestamp(dt)
    let formattedDate = date.abbreviatedWeekday()
    return formattedDate
  }

  var formattedTemp: String? {
    return String(format: "%.0f", temp.day) + "°"
  }

  var formattedTempMin: String? {
    return "\(String(format: "%.0f", temp.min))°"
  }

  var formattedTempMax: String? {
    return "\(String(format: "%.0f", temp.max))°"
  }

  var formattedTempMinMax: String? {
    return "\(String(format: "%.0f", temp.min))°/\(String(format: "%.0f", temp.min))°"
  }

  var formattedWind: String? {
    return String(format: "%.1f", windSpeed) + "km/h"
  }

  var formattedHumidity: String? {
    return String(humidity) + "%"
  }

}

extension WeatherForecastData {
  var currentDateTime: String? {
    let date = Date.dateFromUnixTimestamp(current.dt)
    let formattedDate = date.formattedWeekdayTime()
    return formattedDate
  }

  var formattedHumidity: String? {
    return String(current.humidity) + "%"
  }

  var formattedWind: String? {
    return String(format: "%.1f", current.windSpeed) + "km/h"
  }

  var formattedTemp: String? {
    return String(format: "%.0f", current.temp) + "°"
  }

  var formattedTempMin: String? {
    return String(format: "%.0f", daily.first?.temp.min ?? 0) + "°"
  }

  var formattedTempMax: String? {
    return String(format: "%.0f", daily.first?.temp.max ?? 0) + "°"
  }
}
