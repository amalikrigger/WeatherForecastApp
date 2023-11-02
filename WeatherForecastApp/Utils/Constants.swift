//
//  Constants.swift
//  WeatherForecastApp
//
//  Created by Amali Krigger on 10/29/23.
//

import Foundation

struct Constants {
  static let weatherForecastDataBaseURL = "https://api.openweathermap.org/data/2.5/onecall"
  static let apiKey = URLQueryItem(name: "appid", value: "fad7be6d3efab6853151833dfe5b49c2")
  static let cityWeatherForecastApiKey = URLQueryItem(
    name: "appid", value: "ff902a941caba2efc75c211425bd10fe")
  static let degreesType = URLQueryItem(name: "units", value: "imperial")
  static let exclude = URLQueryItem(name: "exclude", value: "alerts,minutely")
  static let cityWeatherForecastDataBaseURL = "https://api.openweathermap.org/data/2.5/weather"

  static func getWeatherIcon(icon: String) -> String {
    let imageEndpoint = "https://openweathermap.org/img/wn/\(icon)@2x.png"
    return imageEndpoint
  }

  static func getWeatherIconString(icon: String) -> String? {
    let weatherIcon = WeatherIcon(rawValue: icon)
    switch weatherIcon {
    case .clearSkyDay, .clearSkyNight: return "sun.max.fill"
    case .fewCloudsDay, .fewCloudsNight: return "cloud.sun.fill"
    case .scatteredCloudsDay, .scatteredCloudsNight: return "cloud.sun.fill"
    case .brokenCloudsDay, .brokenCloudsNight, .overcastCloudsDay, .overcastCloudsNight:
      return "cloud.fill"
    case .showerRainDay, .showerRainNight: return "cloud.rain.fill"
    case .lightIntensityDrizzle, .drizzle, .heavyIntensityDrizzle,
      .lightIntensityDrizzleRain, .drizzleRain, .heavyIntensityDrizzleRain,
      .showerRainAndDrizzle, .heavyShowerRainAndDrizzle, .showerDrizzle,
      .lightIntensityShowerRain, .showerRain, .heavyIntensityShowerRain, .raggedShowerRain:
      return "cloud.drizzle.fill"
    case .rainDay, .rainNight, .lightRain, .moderateRain, .heavyIntensityRain, .veryHeavyRain,
      .extremeRain:
      return "cloud.heavyrain.fill"
    case .freezingRain: return "cloud.sleet.fill"
    case .lightSnow, .snow, .heavySnow, .sleet, .lightShowerSleet, .showerSleet,
      .lightRainAndSnow, .rainAndSnow, .lightShowerSnow, .showerSnow, .heavyShowerSnow:
      return "cloud.snow.fill"
    case .mist, .smoke, .haze, .sandDustWhirls, .fog, .sand, .dust, .volcanicAsh, .squalls,
      .tornado:
      return "cloud.fog.fill"
    default: return "questionmark.diamond.fill"
    }
  }
}
