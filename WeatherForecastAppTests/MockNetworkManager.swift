//
//  MockNetworkManager.swift
//  WeatherForecastAppTests
//
//  Created by Amali Krigger on 11/1/23.
//

import Foundation

@testable import WeatherForecastApp

enum MockNetworkManagerError: Error {
  case apiFailed
}

class MockNetworkManager: Networkable {
  var success = true
  func execute<T>(_ request: WeatherForecastApp.Requestable, modelType: T.Type) async throws -> T
  where T: Decodable {
    if success {
      return await WeatherForecastData.getMockWeatherForecast() as! T
    } else {
      throw MockNetworkManagerError.apiFailed
    }
  }
}

extension WeatherForecastData {
  static func getMockWeatherForecast() async -> WeatherForecastData {
    let weatherData = WeatherForecastData(
      lon: -122.0312,
      lat: 37.3323,
      timezone: "America/Los_Angeles",
      timezoneOffset: -25200,
      current: CurrentWeather(
        dt: 1_698_825_515,
        sunrise: 1_698_849_152,
        sunset: 1_698_887_445,
        temp: 286.33,
        feelsLike: 285.01,
        pressure: 1018,
        humidity: 50,
        dewPoint: 276.15,
        uvi: 0,
        clouds: 0,
        visibility: 10000,
        windSpeed: 0,
        windDeg: 0,
        weather: [
          WeatherInfo(
            id: 800,
            main: "Clear",
            description: "clear sky",
            icon: "01n"
          )
        ], rain: nil
      ),
      hourly: [
        HourlyWeather(
          dt: 1_698_822_000,
          temp: 286.48,
          feelsLike: 285.07,
          pressure: 1018,
          humidity: 46,
          dewPoint: 275.11,
          uvi: 0,
          clouds: 1,
          visibility: 10000,
          windSpeed: 0.91,
          windDeg: 139,
          windGust: 1.06,
          weather: [
            WeatherInfo(
              id: 800,
              main: "Clear",
              description: "clear sky",
              icon: "01n"
            )
          ],
          pop: 0
        ),
        HourlyWeather(
          dt: 1_698_825_600,
          temp: 286.33,
          feelsLike: 285.01,
          pressure: 1018,
          humidity: 50,
          dewPoint: 276.15,
          uvi: 0,
          clouds: 0,
          visibility: 10000,
          windSpeed: 0.69,
          windDeg: 142,
          windGust: 0.97,
          weather: [
            WeatherInfo(
              id: 800,
              main: "Clear",
              description: "clear sky",
              icon: "01n"
            )
          ],
          pop: 0
        ),
      ],
      daily: [
        DailyWeather(
          dt: 1_698_865_200,
          sunrise: 1_698_849_152,
          sunset: 1_698_887_445,
          moonrise: 1_698_897_780,
          moonset: 1_698_864_840,
          moonPhase: 0.64,
          temp: Temperature(
            day: 296.32,
            min: 285.47,
            max: 298.29,
            night: 288.58,
            eve: 292.43,
            morn: 285.6
          ),
          feelsLike: FeelsLike(
            day: 295.06,
            night: 286.81,
            eve: 290.94,
            morn: 283.66
          ),
          pressure: 1018,
          humidity: 14,
          dewPoint: 266.48,
          windSpeed: 2.07,
          windDeg: 353,
          windGust: 2.16,
          weather: [
            WeatherInfo(
              id: 800,
              main: "Clear",
              description: "clear sky",
              icon: "01d"
            )
          ],
          clouds: 5,
          pop: 0,
          rain: nil,
          uvi: 3.93
        ),
        DailyWeather(
          dt: 1_698_951_600,
          sunrise: 1_698_935_615,
          sunset: 1_698_973_781,
          moonrise: 1_698_987_660,
          moonset: 1_698_954_540,
          moonPhase: 0.67,
          temp: Temperature(
            day: 296.15,
            min: 287.02,
            max: 297.64,
            night: 289.31,
            eve: 292.61,
            morn: 287.12
          ),
          feelsLike: FeelsLike(
            day: 294.9,
            night: 288.99,
            eve: 291.24,
            morn: 286.65
          ),
          pressure: 1018,
          humidity: 17,
          dewPoint: 267.9,
          windSpeed: 2.45,
          windDeg: 328,
          windGust: 2.73,
          weather: [
            WeatherInfo(
              id: 800,
              main: "Clear",
              description: "clear sky",
              icon: "01d"
            )
          ],
          clouds: 2,
          pop: 0,
          rain: nil,
          uvi: 3.87
        ),
      ]
    )
    return weatherData
  }
}
