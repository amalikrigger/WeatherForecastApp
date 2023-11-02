//
//  HourlyWeatherForecast.swift
//  WeatherForecastApp
//
//  Created by Amali Krigger on 10/28/23.
//

import SwiftUI

struct HourlyWeatherForecastView: View {
  let screenWidth = UIScreen.main.bounds.size.width
  @EnvironmentObject var weatherForecastViewModel: WeatherForecastViewModel
  var body: some View {
    HStack {
      Spacer().frame(width: 50)
      RoundedRectangle(cornerRadius: 20)
        .frame(width: screenWidth, height: 130)
        .foregroundColor(Color(red: 149 / 255, green: 182 / 255, blue: 233 / 255).opacity(0.6))
        .overlay(
          ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 40) {
              ForEach(
                0..<(weatherForecastViewModel.weatherForecastData?.hourly.count ?? 1), id: \.self
              ) {
                index in
                VStack {
                  Text(
                    (index == 0
                      ? "Now"
                      : weatherForecastViewModel.weatherForecastData?.hourly[index].hourlyTime)
                      ?? "Now"
                  )
                  .foregroundColor(.black)
                  .bold()
                  Image(
                    systemName: Constants.getWeatherIconString(
                      icon: weatherForecastViewModel.weatherForecastData?.hourly[index].weather
                        .first?.icon ?? "50d") ?? "sun.max.fill"
                  )
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(width: 30, height: 30)
                  .foregroundColor(.black)
                  Text(
                    weatherForecastViewModel.weatherForecastData?.hourly[index].hourlyTemp ?? "21°"
                  )
                  .foregroundColor(.black)
                }
              }
            }
            .padding()
          }
          .cornerRadius(10)
          .padding(.leading)
          .padding(.trailing, 35))
    }
  }

}

#Preview {
  HourlyWeatherForecastView()
    .environmentObject(WeatherForecastViewModel(networkManager: NetworkManager()))
}
