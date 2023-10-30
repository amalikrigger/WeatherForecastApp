//
//  WeatherForecast.swift
//  WeatherForecastApp
//
//  Created by Amali Krigger on 10/27/23.
//

import SwiftUI

struct CurrentWeatherView: View {
  @EnvironmentObject var coordinator: Coordinator
  @EnvironmentObject var currentWeatherViewModel: CurrentWeatherViewModel
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
            Text(currentWeatherViewModel.currentWeatherData?.currentDateTime ?? "Tue, 17:34")
              .foregroundColor(.black)
            ScalableText(text: currentWeatherViewModel.currentWeatherData?.timezone ?? "None")
            Text(
              currentWeatherViewModel.currentWeatherData?.current.weather.first?.main.capitalized
                ?? "Sunny with clouds"
            )
            .font(.title2)
            .foregroundColor(.black)
            Spacer()
            WeatherIcon(width: 200, height: 100)
              Spacer()
            ZStack {
              Text(currentWeatherViewModel.currentWeatherData?.formattedTemp ?? "21°")
                .padding(.leading, 25)
                .font(.system(size: 80))
              HStack {
                VStack {
                  Text(Image(systemName: "wind"))
                    .font(.system(size: 22))
                  Text(currentWeatherViewModel.currentWeatherData?.formattedWind ?? "7km/h")
                    .foregroundColor(.black)
                    .bold()
                  Text("Wind")
                    .foregroundColor(.black)
                }
                Spacer()
                VStack {
                  Text(Image(systemName: "drop"))
                    .font(.system(size: 22))
                  Text(currentWeatherViewModel.currentWeatherData?.formattedHumidity ?? "36%")
                    .foregroundColor(.black)
                    .bold()
                  Text("Humidity")
                    .foregroundColor(.black)
                }
              }
              .padding(.horizontal, 30)
              .frame(width: screenWidth)
            }

            Text(
              currentWeatherViewModel.currentWeatherData?.current.weather.first?.description
                .capitalized ?? "Pretty warm"
            )
            .font( /*@START_MENU_TOKEN@*/.title /*@END_MENU_TOKEN@*/)
            Spacer().frame(height: 10)
            Text(
              "From \(currentWeatherViewModel.currentWeatherData?.formattedTempMin ?? "18°") To: \(currentWeatherViewModel.currentWeatherData?.formattedTempMax ?? "23°")"
            )
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
          currentWeatherViewModel.getCurrentWeatherData()
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
        currentWeatherViewModel.location = location
        print("DEBUG: \(String(describing: currentWeatherViewModel.location))")
        currentWeatherViewModel.getCurrentWeatherData()
      }
    }
  }
}

#Preview {
  CurrentWeatherView()
    .environmentObject(Coordinator())
    .environmentObject(CurrentWeatherViewModel(networkManager: NetworkManager()))
}