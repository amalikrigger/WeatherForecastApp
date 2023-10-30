//
//  WeatherForecastViewModel.swift
//  WeatherForecastApp
//
//  Created by Amali Krigger on 10/29/23.
//

import CoreLocation
import Foundation

class WeatherForecastViewModel: ObservableObject {
  var location: CLLocationCoordinate2D?
  let networkManager: Networkable
  @Published var weatherForecast: WeatherForecast?
  init(networkManager: Networkable) {
    self.networkManager = networkManager
  }

  func getWeatherForecast() {
    Task {
      guard let location = self.location else {
        return
      }
      let networkRequest = NetworkRequest(
        baseUrl: Constants.baseURL, apiKey: Constants.apiKey,
        path: "",
        params: [
          Constants.degreesType,
          URLQueryItem(name: "lat", value: String(location.latitude)),
          URLQueryItem(name: "lon", value: String(location.longitude)),
        ],
        type: .GET, headers: [:])
      do {
        let result = try await networkManager.execute(networkRequest, modelType: WeatherForecast.self)
        print(result ?? "FAILED")
        DispatchQueue.main.async {
          self.weatherForecast = result
        }
      } catch {
        print(error.localizedDescription)
      }
    }
  }
}
