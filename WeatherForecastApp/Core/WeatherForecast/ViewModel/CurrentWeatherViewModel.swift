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
                handleError(LocationError.locationNotFound)
                return
            }

            let networkRequest = NetworkRequest(
                baseUrl: Constants.currentWeatherDataBaseURL,
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
                    networkRequest, modelType: CurrentWeatherData.self)
                guard let result = result else {
                    return
                }
                handleSuccess(result)
            } catch {
                handleError(error)
            }
        }
    }

    func getHardCodedLocation()
    {
        Task {
            let networkRequest = NetworkRequest(
                baseUrl: Constants.currentWeatherDataBaseURL,
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
                    networkRequest, modelType: CurrentWeatherData.self)
                guard let result = result else {
                    return
                }
                handleSuccess(result)
            } catch {
                handleError(error)
            }
        }
    }

    private func handleSuccess(_ result: CurrentWeatherData) {
        DispatchQueue.main.async {
            self.currentWeatherData = result
            self.dailyWeatherData = Array(result.daily[1..<6])
            self.state = .loaded
        }
    }

    private func handleError(_ error: Error) {
        DispatchQueue.main.async {
            self.state = .error
            print(error.localizedDescription)
        }
    }
}
