//
//  WeatherForecastViewModel.swift
//  WeatherForecastApp
//
//  Created by Amali Krigger on 10/29/23.
//

import CoreLocation
import Foundation

class CurrentWeatherViewModel: ObservableObject {
  var location: CLLocationCoordinate2D?
  let networkManager: Networkable
  @Published var currentWeatherData: CurrentWeatherData?
  @Published var dailyWeatherData: [DailyWeather?]?
  init(networkManager: Networkable) {
    self.networkManager = networkManager
  }

  func getCurrentWeatherData() {
    Task {
      guard let location = self.location else {
        return
      }
      let networkRequest = NetworkRequest(
        baseUrl: Constants.currentWeatherDataBaseURL, apiKey: Constants.apiKey,
        path: "",
        params: [
          Constants.degreesType,
          Constants.exclude,
          URLQueryItem(name: "lat", value: String(location.latitude)),
          URLQueryItem(name: "lon", value: String(location.longitude)),
        ],
        type: .GET, headers: [:])
      do {
        let result = try await networkManager.execute(
          networkRequest, modelType: CurrentWeatherData.self)
        print(result ?? "FAILED")
        DispatchQueue.main.async {
          self.currentWeatherData = result
          self.dailyWeatherData = Array(result?.daily[1..<6] ?? [])
        }
      } catch {
        print(error.localizedDescription)
      }
    }
  }
}
