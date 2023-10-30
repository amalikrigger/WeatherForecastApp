//
//  WeatherForecast.swift
//  WeatherForecastApp
//
//  Created by Amali Krigger on 10/29/23.
//

import Foundation

struct WeatherForecast: Decodable {
    var coord: Coord
    var weather: [WeatherInfo]
    var main: Main
    var name: String
    var wind: Wind
    var dt: Double
    var timezone: Double

    struct Coord: Decodable {
        var lon: Double
        var lat: Double
    }

    struct WeatherInfo: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }

    struct Main: Decodable {
        var temp: Double
        var feelsLike: Double
        var tempMin: Double
        var tempMax: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct Wind: Decodable {
        var speed: Double
        var deg: Double
    }
}

extension WeatherForecast {
    var currentDateTime: String? {
        let date = Date.dateFromUnixTimestamp(dt)
        let formattedDate = date.formattedWeekdayTime()
        return formattedDate
    }
    
    var formattedHumidity: String? {
        return String(main.humidity) + "%"
    }
    
    var formattedWind: String? {
        return String(format: "%.1f", wind.speed) + "km/h"
    }
    
    var formattedTemp: String? {
        return String(format: "%.0f", main.temp) + "°"
    }
    
    var formattedTempMin: String? {
        return String(format: "%.0f", main.tempMin) + "°"
    }
    
    var formattedTempMax: String? {
        return String(format: "%.0f", main.tempMax) + "°"
    }
    
}
