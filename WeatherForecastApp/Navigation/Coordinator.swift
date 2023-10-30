//
//  Coordinator.swift
//  WeatherForecastApp
//
//  Created by Amali Krigger on 10/29/23.
//

import Foundation
import SwiftUI

enum Page: Hashable {
    case dailyWeatherForecast
}

class Coordinator: ObservableObject {
    
    @Published var path = NavigationPath()
    
    func showDailyWeatherForecast() {
        path.append(Page.dailyWeatherForecast)
    }
    
}

