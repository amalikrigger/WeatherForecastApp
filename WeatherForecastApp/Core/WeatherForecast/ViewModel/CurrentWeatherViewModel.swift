//
//  WeatherForecastViewModel.swift
//  WeatherForecastApp
//
//  Created by Amali Krigger on 10/29/23.
//

import CoreLocation
import Foundation

enum ViewState {
    case loading
    case loaded
    case error
}

class CurrentWeatherViewModel: ObservableObject {
  var location: CLLocationCoordinate2D?
  let networkManager: Networkable
  @Published private(set) var currentWeatherData: CurrentWeatherData?
  @Published private(set) var dailyWeatherData: [DailyWeather?]?
  @Published private(set) var state = ViewState.loading
  init(networkManager: Networkable) {
    self.networkManager = networkManager
  }

  func getCurrentWeatherData() {
    Task {
      guard let location = self.location else {
          DispatchQueue.main.async {
              self.state = .error
          }
       
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
          self.state = .loaded
        }
      } catch {
          DispatchQueue.main.async {
              self.state = .error
              print(error.localizedDescription)
          }

      }
    }
  }
    
    func getHardCodedLocation() {
      Task {
        let networkRequest = NetworkRequest(
          baseUrl: Constants.currentWeatherDataBaseURL, apiKey: Constants.apiKey,
          path: "",
          params: [
            Constants.degreesType,
            Constants.exclude,
            URLQueryItem(name: "lat", value: "37.33233141"),
            URLQueryItem(name: "lon", value: "122.0312186"),
          ],
          type: .GET, headers: [:])
        do {
          let result = try await networkManager.execute(
            networkRequest, modelType: CurrentWeatherData.self)
//          print(result ?? "FAILED")
          DispatchQueue.main.async {
            self.currentWeatherData = result
            self.dailyWeatherData = Array(result?.daily[1..<6] ?? [])
            self.state = .loaded
          }
        } catch {
            DispatchQueue.main.async {
                self.state = .error
                print(error.localizedDescription)
            }
        }
      }
    }
}
