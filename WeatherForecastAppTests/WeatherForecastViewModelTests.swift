//
//  WeatherForecastViewModelTests.swift
//  WeatherForecastAppTests
//
//  Created by Amali Krigger on 11/1/23.
//

import CoreLocation
import XCTest

@testable import WeatherForecastApp

final class WeatherForecastViewModelTests: XCTestCase {
  var viewModel: WeatherForecastViewModel?

  override func setUpWithError() throws {
  }

  override func tearDownWithError() throws {
    viewModel = nil
  }

  func testGetWeatherForecastDataSuccess() async throws {
    let mockNetworkManager = MockNetworkManager()
    viewModel = WeatherForecastViewModel(networkManager: mockNetworkManager)
    viewModel?.location = CLLocationCoordinate2D(
      latitude: 33.775396999999998, longitude: -84.387855000000002)
    try? await viewModel!.getWeatherForecastData()
    XCTAssertNotNil(viewModel?.weatherForecastData)
    XCTAssertEqual(viewModel?.state, ViewState.loaded)
  }

  func testGetWeatherForecastDataFailure() async throws {
    let mockNetworkManager = MockNetworkManager()
    mockNetworkManager.success = false
    viewModel = WeatherForecastViewModel(networkManager: mockNetworkManager)
    viewModel?.location = CLLocationCoordinate2D(
      latitude: 33.775396999999998, longitude: -84.387855000000002)
    try? await viewModel!.getWeatherForecastData()
    XCTAssertEqual(viewModel?.state, ViewState.error)
    XCTAssertNil(viewModel?.weatherForecastData)
  }

  func testGetWeatherForecastLocationFailure() async throws {
    let mockNetworkManager = MockNetworkManager()
    viewModel = WeatherForecastViewModel(networkManager: mockNetworkManager)
    viewModel?.location = nil
    try? await viewModel!.getWeatherForecastData()
    XCTAssertEqual(viewModel?.state, ViewState.error)
    XCTAssertNil(viewModel?.weatherForecastData)
  }

  func testGetHardCodedWeatherLocationSuccess() async throws {
    let mockNetworkManager = MockNetworkManager()
    viewModel = WeatherForecastViewModel(networkManager: mockNetworkManager)
    viewModel?.location = CLLocationCoordinate2D(
      latitude: 33.775396999999998, longitude: -84.387855000000002)
    try? await viewModel!.getHardCodedWeatherLocation()
    XCTAssertNotNil(viewModel?.weatherForecastData)
    XCTAssertEqual(viewModel?.state, ViewState.loaded)
  }

  func testGetHardCodedWeatherLocationFailure() async throws {
    let mockNetworkManager = MockNetworkManager()
    mockNetworkManager.success = false
    viewModel = WeatherForecastViewModel(networkManager: mockNetworkManager)
    viewModel?.location = CLLocationCoordinate2D(
      latitude: 33.775396999999998, longitude: -84.387855000000002)
    try? await viewModel!.getHardCodedWeatherLocation()
    XCTAssertEqual(viewModel?.state, ViewState.error)
    XCTAssertNil(viewModel?.weatherForecastData)
  }
}
