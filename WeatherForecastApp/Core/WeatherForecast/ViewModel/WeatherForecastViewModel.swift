//
//  WeatherForecastViewModel.swift
//  WeatherForecastApp
//
//  Created by Amali Krigger on 10/29/23.
//

import CoreLocation
import Foundation

enum LocationError: Error {
  case locationNotFound
  case otherLocationError(String)

  var localizedDescription: String {
    switch self {
    case .locationNotFound:
      return "Location not found."
    case .otherLocationError(let message):
      return "Location error: \(message)"
    }
  }
}

class WeatherForecastViewModel: ObservableObject {
  var location: CLLocationCoordinate2D?
  let networkManager: Networkable

  private(set) var weatherForecastData: WeatherForecastData?
  private(set) var dailyWeatherData: [DailyWeather?]?
  @Published private(set) var state = ViewState.loading

  init(networkManager: Networkable) {
    self.networkManager = networkManager
  }

  @MainActor
  func getWeatherForecastData() async throws {
    guard let location = self.location else {
      handleError(LocationError.locationNotFound)
      return
    }

    let networkRequest = NetworkRequest(
      baseUrl: Constants.weatherForecastDataBaseURL,
      apiKey: Constants.apiKey,
      path: "",
      params: [
        Constants.degreesType,
        Constants.exclude,
        URLQueryItem(name: "lat", value: String(location.latitude)),
        URLQueryItem(name: "lon", value: String(location.longitude)),
      ],
      type: .GET,
      headers: [:]
    )
    do {
      let result = try await networkManager.execute(
        networkRequest, modelType: WeatherForecastData.self)
      //                print(result)
      handleSuccess(result)
    } catch {
      handleError(error)
    }
  }

  @MainActor
  func getHardCodedWeatherLocation() async throws {
    let networkRequest = NetworkRequest(
      baseUrl: Constants.weatherForecastDataBaseURL,
      apiKey: Constants.apiKey,
      path: "",
      params: [
        Constants.degreesType,
        Constants.exclude,
        URLQueryItem(name: "lat", value: "37.33233141"),
        URLQueryItem(name: "lon", value: "122.0312186"),
      ],
      type: .GET,
      headers: [:]
    )

    do {
      let result = try await networkManager.execute(
        networkRequest, modelType: WeatherForecastData.self)
      handleSuccess(result)
    } catch {
      handleError(error)
    }
  }

  private func handleSuccess(_ result: WeatherForecastData) {
    self.weatherForecastData = result
    self.dailyWeatherData = Array(
      result.daily[
        1..<(result.daily.count > 6
          ? (result.daily.count - (result.daily.count - 6)) : result.daily.count)])
    self.state = .loaded
  }

  private func handleError(_ error: Error) {
    self.state = .error
    print(error.localizedDescription)
  }
}
