//
//  FiveDayWeatherForecast.swift
//  WeatherForecastApp
//
//  Created by Amali Krigger on 10/29/23.
//

import SwiftUI

struct FiveDayWeatherForecastView: View {
  let screenWidth = UIScreen.main.bounds.size.width
  let screenHeight = UIScreen.main.bounds.size.height
  @EnvironmentObject var weatherForecastViewModel: WeatherForecastViewModel
  var body: some View {
    RoundedRectangle(cornerRadius: 20)
      .frame(width: screenWidth * 0.9, height: screenHeight * 0.4)
      .foregroundColor(Color(red: 142 / 255, green: 168 / 255, blue: 204 / 255).opacity(0.6))
      .overlay(
        VStack {
          ForEach(0..<(weatherForecastViewModel.dailyWeatherData?.count ?? 0), id: \.self) {
            index in
            GeometryReader {
              geometry in
              HStack(alignment: .center) {
                Spacer()
                Text(weatherForecastViewModel.dailyWeatherData?[index]?.dailyTime ?? "Wed")
                  .foregroundColor(.black)
                  .bold()
                  .frame(width: geometry.size.width * 0.2, alignment: .leading)
                Spacer()
                Image(
                  systemName: Constants.getWeatherIconString(
                    icon: weatherForecastViewModel.dailyWeatherData?[index]?.weather.first?.icon
                      ?? "50d") ?? "sun.max.fill"
                )
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: geometry.size.width * 0.1, height: 40)
                Spacer()
                Text(
                  weatherForecastViewModel.dailyWeatherData?[index]?.weather.first?.main ?? "Rainy"
                )
                .foregroundColor(.black)
                .frame(width: geometry.size.width * 0.4, alignment: .center)
                Spacer()
                ScalableText(
                  alignment: .leading, height: 20, minSize: 20,
                  text: weatherForecastViewModel.dailyWeatherData?[index]?.formattedTempMinMax
                    ?? "09°/13°", widthFactor: 5
                )
                .foregroundColor(.black)
                .frame(width: geometry.size.width * 0.3, alignment: .leading)
              }
              .frame(height: geometry.size.height)
            }
          }
        }
        .padding(.horizontal, 30)
        .padding(.vertical)
      )
      .font(.title3)
  }

}

#Preview {
  FiveDayWeatherForecastView()
    .environmentObject(WeatherForecastViewModel(networkManager: NetworkManager()))
}
