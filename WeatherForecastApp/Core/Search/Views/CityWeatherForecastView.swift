//
//  CityWeatherForecastView.swift
//  WeatherForecastApp
//
//  Created by Amali Krigger on 11/1/23.
//

import SwiftUI

struct CityWeatherForecastView: View {
  let screenWidth = UIScreen.main.bounds.size.width
  let screenHeight = UIScreen.main.bounds.size.height
  @Environment(\.presentationMode) var presentationMode
  @EnvironmentObject var coordinator: Coordinator
  @EnvironmentObject var searchWeatherForecastViewModel: SearchWeatherForecastViewModel
  var body: some View {
    if searchWeatherForecastViewModel.state == .loading {
      ProgressView()
    } else {
      ZStack {
        Image("weather_background_4")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .edgesIgnoringSafeArea( /*@START_MENU_TOKEN@*/.all /*@END_MENU_TOKEN@*/)
          .blur(radius: 4)
        Color.white.opacity(0.2)
          .edgesIgnoringSafeArea( /*@START_MENU_TOKEN@*/.all /*@END_MENU_TOKEN@*/)
        if searchWeatherForecastViewModel.state == .loading {
          ProgressView()

        } else {
          ScrollView(.vertical, showsIndicators: false) {
            VStack {
              ScalableText(
                alignment: .center, height: 40, minSize: 30,
                text: searchWeatherForecastViewModel.cityWeatherForecastData?.name ?? "London",
                widthFactor: 10)
              Text(
                searchWeatherForecastViewModel.cityWeatherForecastData?.weather.first?.main
                  .capitalized
                  ?? "Sunny with clouds"
              )
              .font(.title2)
              .foregroundColor(.black)
              Spacer()
              Image(
                systemName: Constants.getWeatherIconString(
                  icon: searchWeatherForecastViewModel.cityWeatherForecastData?.weather.first?
                    .icon ?? "50d") ?? "sun.max.fill"
              )
              .resizable()
              .frame(width: 200, height: 200)
              .foregroundColor(.black)
              Spacer()
              ZStack {
                Text(
                  searchWeatherForecastViewModel.cityWeatherForecastData?.formattedTemp ?? "21°"
                )
                .padding(.leading, 25)
                .font(.system(size: 90))
                .foregroundColor(.black)
                HStack {
                  VStack(spacing: 5) {
                    Text(Image(systemName: "wind"))
                      .font(.system(size: 20))
                      .foregroundColor(.black)
                    Text(
                      searchWeatherForecastViewModel.cityWeatherForecastData?.formattedWind
                        ?? "7km/h"
                    )
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
                    Text(
                      searchWeatherForecastViewModel.cityWeatherForecastData?.formattedHumidity
                        ?? "36%"
                    )
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
                searchWeatherForecastViewModel.cityWeatherForecastData?.weather.first?.description
                  .capitalized ?? "Pretty warm"
              )
              .font( /*@START_MENU_TOKEN@*/.title /*@END_MENU_TOKEN@*/)
              .foregroundColor(.black)
              Spacer().frame(height: 10)
              Text(
                "From \(searchWeatherForecastViewModel.cityWeatherForecastData?.formattedTempMin ?? "18°") To: \(searchWeatherForecastViewModel.cityWeatherForecastData?.formattedTempMax ?? "23°")"
              )
              .foregroundColor(.black)
              Spacer()
            }
            .padding(.bottom, 35)
            .frame(height: screenHeight * 0.875)
          }
          .refreshable {
          }
        }
      }
      .navigationBarBackButtonHidden()
      .navigationBarItems(
        leading: Button(action: {
          self.presentationMode.wrappedValue.dismiss()
        }) {
          Image(systemName: "chevron.left")
            .bold()
            .foregroundColor(.black)
        }
      )
      .navigationBarTitle(
        Text(
          searchWeatherForecastViewModel.cityWeatherForecastData?.currentDateTime ?? "Tue, 17:34"),
        displayMode: .inline)
    }
  }
}

#Preview {
  CityWeatherForecastView()
    .environmentObject(Coordinator())
    .environmentObject(SearchWeatherForecastViewModel(networkManager: NetworkManager()))
}
