//
//  HourlyWeatherForecast.swift
//  WeatherForecastApp
//
//  Created by Amali Krigger on 10/28/23.
//

import SwiftUI

struct HourlyWeatherForecastView: View {
  let screenWidth = UIScreen.main.bounds.size.width
  var body: some View {
    HStack {
      Spacer().frame(width: 50)
      RoundedRectangle(cornerRadius: 20)
        .frame(width: screenWidth, height: 130)
        .foregroundColor(Color(red: 149 / 255, green: 182 / 255, blue: 233 / 255).opacity(0.6))
        .overlay(
          ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 40) {
              ForEach(1..<10) { index in
                VStack {
                  Text("Now")
                    .foregroundColor(.black)
                    .bold()
                  Image("cloudy_icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                  Text("21°")
                    .foregroundColor(.black)
                }
              }
            }
            .padding()
          }
          .cornerRadius(10)
          .padding(.leading)
          .padding(.trailing, 35)
        )
    }
  }
}

#Preview {
  HourlyWeatherForecastView()
}
