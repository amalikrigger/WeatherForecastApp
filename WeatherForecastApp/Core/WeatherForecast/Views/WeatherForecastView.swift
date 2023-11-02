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
        if weatherForecastViewModel.state == .loading {
          ProgressView()
        } else {
          ScrollView(.vertical, showsIndicators: false) {
            VStack {
              ScalableText(
                alignment: .center, height: 40, minSize: 30,
                text: weatherForecastViewModel.weatherForecastData?.timezone ?? "None",
                widthFactor: 10)
              Text(
                weatherForecastViewModel.weatherForecastData?.current.weather.first?.main
                  .capitalized
                  ?? "Sunny with clouds"
              )
              .font(.title2)
              .foregroundColor(.black)
              Spacer()
              Image(
                systemName: Constants.getWeatherIconString(
                  icon: weatherForecastViewModel.weatherForecastData?.current.weather.first?.icon
                    ?? "50d") ?? "sun.max.fill"
              )
              .resizable()
              .frame(width: 200, height: 200)
              .foregroundColor(.black)
              Spacer()
              ZStack {
                Text(weatherForecastViewModel.weatherForecastData?.formattedTemp ?? "21°")
                  .padding(.leading, 25)
                  .font(.system(size: 90))
                  .foregroundColor(.black)
                HStack {
                  VStack(spacing: 5) {
                    Text(Image(systemName: "wind"))
                      .font(.system(size: 20))
                      .foregroundColor(.black)
                    Text(weatherForecastViewModel.weatherForecastData?.formattedWind ?? "7km/h")
                      .font(.subheadline)
                      .foregroundColor(.black)
                      .bold()
                    Text("Wind")
                      .foregroundColor(.black)
                      .font(.subheadline)
                  }
                  Spacer()
                  VStack(spacing: 5) {
                    Text(Image(systemName: "drop"))
                      .font(.system(size: 20))
                      .foregroundColor(.black)
                    Text(weatherForecastViewModel.weatherForecastData?.formattedHumidity ?? "36%")
                      .font(.subheadline)
                      .foregroundColor(.black)
                      .bold()
                    Text("Humidity")
                      .foregroundColor(.black)
                      .font(.subheadline)

                  }
                }
                .padding(.horizontal, 35)
                .frame(width: screenWidth)
              }
              Text(
                weatherForecastViewModel.weatherForecastData?.current.weather.first?.description
                  .capitalized ?? "Pretty warm"
              )
              .font( /*@START_MENU_TOKEN@*/.title /*@END_MENU_TOKEN@*/)
              .foregroundColor(.black)
              Spacer().frame(height: 10)
              Text(
                "From \(weatherForecastViewModel.weatherForecastData?.formattedTempMin ?? "18°") To: \(weatherForecastViewModel.weatherForecastData?.formattedTempMax ?? "23°")"
              )
              .foregroundColor(.black)
              Spacer()
              HStack(alignment: .bottom) {
                Text("Today")
                  .font( /*@START_MENU_TOKEN@*/.title /*@END_MENU_TOKEN@*/)
                  .foregroundColor(.black)
                  .bold()
                  .padding(.leading, 30)
                Spacer()
                HStack {
                  Text("Next 5 Days")
                    .font(.title3)
                    .foregroundColor(.black)
                  Image(systemName: "chevron.right")
                    .resizable()
                    .frame(width: 5, height: 10)
                    .padding(.top, 3)
                    .bold()
                    .foregroundColor(.black)
                }
                .padding(.trailing)
                .onTapGesture {
                  coordinator.showDailyWeatherForecast()
                }
              }
              .frame(width: screenWidth)
              HourlyWeatherForecastView()
            }
            .padding(.bottom, 35)
            .frame(height: screenHeight * 0.875)
          }
          .refreshable {
            Task {
              try? await weatherForecastViewModel.getHardCodedWeatherLocation()
            }
          }
        }
      }
      .navigationDestination(
        for: Page.self,
        destination: {
          page in
          switch page {
          case .weatherForecast:
            WeatherForecastView()
          case .dailyWeatherForecast:
            DailyWeatherForecastView()
          case .searchCityWeatherForecast:
            SearchWeatherForecastView()
          case .cityWeatherForecast:
            CityWeatherForecastView()
          }
        }
      )
      .navigationBarBackButtonHidden()
      .navigationBarItems(
        trailing: Button(action: {
          coordinator.showSearchCityWeatherForecast()
        }) {
          Image(systemName: "magnifyingglass")
            .resizable()
            .foregroundColor(.black)
            .frame(width: 20, height: 20)
        }
      )
      .navigationBarTitle(
        Text(weatherForecastViewModel.weatherForecastData?.currentDateTime ?? "Tue, 17:34"),
        displayMode: .inline)
      .foregroundColor(.black)
    }
    .onReceive(LocationManager.shared.$location) {
      location in
      if let location = location {
        weatherForecastViewModel.location = location
        print("DEBUG: \(String(describing: weatherForecastViewModel.location))")
        Task {
          try? await weatherForecastViewModel.getWeatherForecastData()
        }
      }
    }
  }

}

#Preview {
  WeatherForecastView()
    .environmentObject(Coordinator())
    .environmentObject(WeatherForecastViewModel(networkManager: NetworkManager()))
}
