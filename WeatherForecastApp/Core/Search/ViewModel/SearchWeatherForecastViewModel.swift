//
//  SearchWeatherForecastViewModel.swift
//  WeatherForecastApp
//
//  Created by Amali Krigger on 11/1/23.
//

import Foundation

class SearchWeatherForecastViewModel: ObservableObject {
  let networkManager: Networkable
  @Published var searchTerm: String = ""
  private(set) var cityWeatherForecastData: CityWeatherForecastData?
  @Published private(set) var state = ViewState.loading

  init(networkManager: Networkable) {
    self.networkManager = networkManager
  }

  @MainActor
  func getSearchWeatherForecastData() async throws {
    let networkRequest = NetworkRequest(
      baseUrl: Constants.cityWeatherForecastDataBaseURL,
      apiKey: Constants.cityWeatherForecastApiKey,
      path: "",
      params: [
        Constants.degreesType,
        URLQueryItem(name: "q", value: searchTerm),
      ],
      type: .GET,
      headers: [:]
    )
    do {
      let result = try await networkManager.execute(
        networkRequest, modelType: CityWeatherForecastData.self)
      print(result)
      handleSuccess(result)
    } catch {
      handleError(error)
    }
  }

  private func handleSuccess(_ result: CityWeatherForecastData) {
    self.cityWeatherForecastData = result
    self.state = .loaded
  }

  private func handleError(_ error: Error) {
    self.state = .error
    print(error.localizedDescription)
  }
}
