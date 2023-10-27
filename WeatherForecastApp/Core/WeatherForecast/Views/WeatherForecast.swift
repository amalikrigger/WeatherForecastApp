//
//  WeatherForecast.swift
//  WeatherForecastApp
//
//  Created by Amali Krigger on 10/27/23.
//

import SwiftUI

struct WeatherForecast: View {
  let screenWidth = UIScreen.main.bounds.size.width
  let screenHeight = UIScreen.main.bounds.size.height
  var body: some View {
    ZStack {
      Image("weather_background")
        .resizable()
        .aspectRatio(contentMode: .fill)
        .edgesIgnoringSafeArea( /*@START_MENU_TOKEN@*/.all /*@END_MENU_TOKEN@*/)
        .blur(radius: 4)

      Color.white.opacity(0.2)
        .edgesIgnoringSafeArea( /*@START_MENU_TOKEN@*/.all /*@END_MENU_TOKEN@*/)

      VStack {
        Text("Tue, 17:34")
          .foregroundColor(.black)
        Text("Tokyo")
          .font(.system(size: 60))
          .foregroundColor(.black)
        Text("Sunny with clouds")
          .font(.title2)
          .foregroundColor(.black)
        Image("cloudy_icon")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 200, height: 200)
        HStack(spacing: 30) {
          VStack {
            Text(Image(systemName: "wind"))
            Text("7km/h")
              .foregroundColor(.black)
              .bold()
            Text("Wind")
              .foregroundColor(.black)
          }

          Text("21°")
            .font(.system(size: 80))

          VStack {
            Text(Image(systemName: "drop"))

            Text("36%")
              .foregroundColor(.black)
              .bold()
            Text("Humidity")
              .foregroundColor(.black)
          }
        }
        Text("Pretty warm")
          .font( /*@START_MENU_TOKEN@*/.title /*@END_MENU_TOKEN@*/)
        Spacer().frame(height: 10)
        Text("From 18° To: 23°")
        Spacer()
        HStack {
          Text("Today")
            .font( /*@START_MENU_TOKEN@*/.title /*@END_MENU_TOKEN@*/)
            .bold()
            .padding(.leading, 30)
          Spacer()
          HStack {
            Text("Next 7 Days")
              .font(.title3)

            Image(systemName: "chevron.right")
              .resizable()
              .frame(width: 5, height: 10)
          }
          .padding(.trailing)

        }
        .frame(width: screenWidth)

        HStack {
          Spacer().frame(width: 50)
          RoundedRectangle(cornerRadius: 20)
            .frame(width: screenWidth, height: 130)
            .foregroundColor(Color(red: 149 / 255, green: 182 / 255, blue: 233 / 255).opacity(0.6))
            .overlay(
              ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 40) {  // Adjust spacing as needed
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
              .padding(.horizontal)
            )
        }

      }
      .padding(.vertical)
    }
  }
}

#Preview {
  WeatherForecast()
}
