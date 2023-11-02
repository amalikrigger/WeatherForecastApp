//
//  LocationManager.swift
//  WeatherForecastApp
//
//  Created by Amali Krigger on 10/29/23.
//

import CoreLocation
import Foundation

class LocationManager: NSObject, ObservableObject {
  private let locationManager = CLLocationManager()
  @Published var location: CLLocationCoordinate2D?
  static let shared = LocationManager()
  override init() {
    super.init()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
  }

}

extension LocationManager: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.first else {
      return
    }
    self.location = location.coordinate
    print(location)
    locationManager.stopUpdatingLocation()
  }

  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("Error getting location", error)
  }
}
