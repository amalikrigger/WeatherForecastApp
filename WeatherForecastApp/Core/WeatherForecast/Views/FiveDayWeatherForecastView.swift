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
  @EnvironmentObject var currentWeatherViewModel: CurrentWeatherViewModel
  var body: some View {
    RoundedRectangle(cornerRadius: 20)
      .frame(width: screenWidth * 0.9, height: screenHeight * 0.4)
      .foregroundColor(Color(red: 142 / 255, green: 168 / 255, blue: 204 / 255).opacity(0.6))
      .overlay(
        VStack(spacing: 25) {
            ForEach(0..<(currentWeatherViewModel.dailyWeatherData?.count ?? 0) , id: \.self) { index in
            HStack {
                Text(currentWeatherViewModel.dailyWeatherData?[index]?.dailyTime ?? "Wed")
                .foregroundColor(.black)
                .bold()
              Spacer()
              Image("cloudy_icon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
              Spacer()

                Text(currentWeatherViewModel.dailyWeatherData?[index]?.weather.first?.main ?? "Rainy")
                .foregroundColor(.black)
              Spacer()
                Text(currentWeatherViewModel.dailyWeatherData?[index]?.formattedTempMinMax ?? "09°/13°")
                  .foregroundColor(.black)
            }
          }
        }
        .padding(.horizontal, 30)
      )
      .font(.title3)
  }
}

#Preview {
  FiveDayWeatherForecastView()
        .environmentObject(CurrentWeatherViewModel(networkManager: NetworkManager()))
}
