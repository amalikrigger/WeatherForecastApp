//
//  WeatherIcon.swift
//  WeatherForecastApp
//
//  Created by Amali Krigger on 10/31/23.
//

import Foundation

enum WeatherIcon: String {
    case clearSkyDay = "01d"
    case clearSkyNight = "01n"
    case fewCloudsDay = "02d"
    case fewCloudsNight = "02n"
    case scatteredCloudsDay = "03d"
    case scatteredCloudsNight = "03n"
    case brokenCloudsDay,
    overcastCloudsDay = "04d"
    case brokenCloudsNight,
    overcastCloudsNight = "04n"
    case showerRainDay,
    lightIntensityDrizzle,
    drizzle,
    heavyIntensityDrizzle,
    lightIntensityDrizzleRain,
    drizzleRain,
    heavyIntensityDrizzleRain,
    showerRainAndDrizzle,
    heavyShowerRainAndDrizzle,
    showerDrizzle,
    lightIntensityShowerRain,
    showerRain,
    heavyIntensityShowerRain,
    raggedShowerRain = "09d"
    case showerRainNight = "09n"
    case rainDay,
    lightRain,
    moderateRain,
    heavyIntensityRain,
    veryHeavyRain,
    extremeRain = "10d"
    case rainNight = "10n"
    case freezingRain, lightSnow, snow, heavySnow, sleet, lightShowerSleet, showerSleet, lightRainAndSnow, rainAndSnow,
    lightShowerSnow, showerSnow, heavyShowerSnow = "13d"
    case snowNight, moderateRainNight = "13n"
    case mist,
    smoke,
    haze,
    sandDustWhirls,
    fog,
    sand,
    dust,
    volcanicAsh,
    squalls,
    tornado = "50d"
    case mistNight, lightRainNight = "50n"
    case heavyRainDay = "14d"
    case heavyRainNight = "14n"
    case thunderstormWithLightRainDay,
    thunderstormWithLightRainNight,
    thunderstormWithRainDay,
    thunderstormWithRainNight,
    thunderstormWithHeavyRainDay,
    thunderstormWithHeavyRainNight,
    thunderstormWithDrizzleDay,
    thunderstormWithDrizzleNight,
    thunderstormWithHeavyDrizzleDay,
    thunderstormWithHeavyDrizzleNight = "11d"
}
