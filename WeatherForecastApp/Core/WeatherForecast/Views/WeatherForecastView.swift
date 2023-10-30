//
//  WeatherForecast.swift
//  WeatherForecastApp
//
//  Created by Amali Krigger on 10/27/23.
//

import SwiftUI

struct WeatherForecastView: View {
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
            Text(weatherForecastViewModel.weatherForecast?.currentDateTime ?? "Tue, 17:34")
              .foregroundColor(.black)
            Text(weatherForecastViewModel.weatherForecast?.name ?? "None")
              .font(.system(size: 60))
              .foregroundColor(.black)
              Text(weatherForecastViewModel.weatherForecast?.weather.first?.description.capitalized ?? "Sunny with clouds")
              .font(.title2)
              .foregroundColor(.black)
            Spacer()
            WeatherIcon(width: 200, height: 100)
              ZStack {
                  Text(weatherForecastViewModel.weatherForecast?.formattedTemp ?? "21°")
                      .padding(.leading, 25)
                  .font(.system(size: 80))
                  HStack {
                    VStack {
                      Text(Image(systemName: "wind"))
                        .font(.system(size: 22))
                        Text(weatherForecastViewModel.weatherForecast?.formattedWind ?? "7km/h")
                        .foregroundColor(.black)
                        .bold()
                      Text("Wind")
                        .foregroundColor(.black)
                    }
                      Spacer()
                    VStack {
                      Text(Image(systemName: "drop"))
                        .font(.system(size: 22))
                        Text(weatherForecastViewModel.weatherForecast?.formattedHumidity ?? "36%")
                        .foregroundColor(.black)
                        .bold()
                      Text("Humidity")
                        .foregroundColor(.black)
                    }
                  }
                  .padding(.horizontal, 30)
                  .frame(width: screenWidth)
              }

              Text(weatherForecastViewModel.weatherForecast?.weather.first?.main ?? "Pretty warm")
              .font( /*@START_MENU_TOKEN@*/.title /*@END_MENU_TOKEN@*/)
            Spacer().frame(height: 10)
            Text("From \(weatherForecastViewModel.weatherForecast?.formattedTempMin ?? "18°") To: \(weatherForecastViewModel.weatherForecast?.formattedTempMax ?? "23°")")
            Spacer()
            HStack(alignment: .bottom) {
              Text("Today")
                .font( /*@START_MENU_TOKEN@*/.title /*@END_MENU_TOKEN@*/)
                .bold()
                .padding(.leading, 30)
              Spacer()
              HStack {
                Text("Next 5 Days")
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

            HourlyWeatherForecastView()

          }
          .padding(.vertical)
          .frame(height: screenHeight * 0.875)
        }
        .refreshable {
            weatherForecastViewModel.getWeatherForecast()
        }
      }
      .navigationDestination(
        for: Page.self,
        destination: { page in
          switch page {
          case .dailyWeatherForecast:
            DailyWeatherForecastView()
          }
        }
      ).navigationBarBackButtonHidden(true)
    }
    .onReceive(LocationManager.shared.$location) { location in
      if let location = location {
        weatherForecastViewModel.location = location
        print("DEBUG: \(String(describing: weatherForecastViewModel.location))")
        weatherForecastViewModel.getWeatherForecast()
      }
    }
  }
}

#Preview {
  WeatherForecastView()
    .environmentObject(Coordinator())
    .environmentObject(WeatherForecastViewModel(networkManager: NetworkManager()))
}
