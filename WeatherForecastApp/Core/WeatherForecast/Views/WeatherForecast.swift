//
//  WeatherForecast.swift
//  WeatherForecastApp
//
//  Created by Amali Krigger on 10/27/23.
//

import SwiftUI

struct WeatherForecast: View {
  @EnvironmentObject var coordinator: Coordinator
  @EnvironmentObject var weatherForecastViewModel: WeatherForecastViewModel
  let screenWidth = UIScreen.main.bounds.size.width
  let screenHeight = UIScreen.main.bounds.size.height
  var body: some View {
    NavigationStack(path: $coordinator.path) {
      ZStack {
        Image("weather_background")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .edgesIgnoringSafeArea( /*@START_MENU_TOKEN@*/.all /*@END_MENU_TOKEN@*/)
          .blur(radius: 4)
        Color.white.opacity(0.2)
          .edgesIgnoringSafeArea( /*@START_MENU_TOKEN@*/.all /*@END_MENU_TOKEN@*/)
        ScrollView(.vertical, showsIndicators: false) {
          VStack {
            Text("Tue, 17:34")
              .foregroundColor(.black)
            Text("Tokyo")
              .font(.system(size: 60))
              .foregroundColor(.black)
            Text("Sunny with clouds")
              .font(.title2)
              .foregroundColor(.black)
            Spacer()
            WeatherIcon(width: 200, height: 100)
            HStack(spacing: 20) {
              VStack {
                Text(Image(systemName: "wind"))
                  .font(.system(size: 22))
                Text("7km/h")
                  .foregroundColor(.black)
                  .bold()
                Text("Wind")
                  .foregroundColor(.black)
              }
              Text("21°")
                .font(.system(size: 90))
                .padding(.leading, 40)
              VStack {
                Text(Image(systemName: "drop"))
                  .font(.system(size: 22))
                Text("36%")
                  .foregroundColor(.black)
                  .bold()
                Text("Humidity")
                  .foregroundColor(.black)
              }
            }
            .frame(width: screenWidth)
            Text("Pretty warm")
              .font( /*@START_MENU_TOKEN@*/.title /*@END_MENU_TOKEN@*/)
            Spacer().frame(height: 10)
            Text("From 18° To: 23°")
            Spacer()
            HStack(alignment: .bottom) {
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
                  .padding(.top, 3)
                  .bold()
              }
              .padding(.trailing)
              .onTapGesture {
                coordinator.showDailyWeatherForecast()
              }

            }
            .frame(width: screenWidth)

            HourlyWeatherForecast()

          }
          .padding(.vertical)
          .frame(height: screenHeight * 0.875)
        }
        .refreshable {
          print("Refresh")
        }
      }
      .navigationDestination(
        for: Page.self,
        destination: { page in
          switch page {
          case .dailyWeatherForecast:
            DailyWeatherForecast()
          }
        }
      ).navigationBarBackButtonHidden(true)
    }
    .onReceive(LocationManager.shared.$location) { location in
      if let location = location {
        weatherForecastViewModel.location = location
        print("DEBUG: \(String(describing: weatherForecastViewModel.location))")
      }
    }
  }
}

#Preview {
  WeatherForecast().environmentObject(Coordinator())
}
