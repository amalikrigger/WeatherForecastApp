//
//  SearchWeatherView.swift
//  WeatherForecastApp
//
//  Created by Amali Krigger on 11/1/23.
//

import SwiftUI

struct SearchWeatherForecastView: View {
  @State private var searchTerm = ""
  @EnvironmentObject var coordinator: Coordinator
  @EnvironmentObject var searchWeatherForecastViewModel: SearchWeatherForecastViewModel
  @Environment(\.presentationMode) var presentationMode
  let screenWidth = UIScreen.main.bounds.size.width
  var body: some View {
    ZStack {
      Image("weather_background_4")
        .resizable()
        .aspectRatio(contentMode: .fill)
        .edgesIgnoringSafeArea( /*@START_MENU_TOKEN@*/.all /*@END_MENU_TOKEN@*/)
        .blur(radius: 4)
      Color.white.opacity(0.2)
        .edgesIgnoringSafeArea( /*@START_MENU_TOKEN@*/.all /*@END_MENU_TOKEN@*/)

      VStack {
        Spacer()

        TextField("Search City", text: $searchWeatherForecastViewModel.searchTerm)
          .frame(height: 30).frame(maxWidth: 350)
          .padding(10)
          .background(
            Color(red: 142 / 255, green: 168 / 255, blue: 204 / 255).opacity(0.9)
          ).cornerRadius(10)
          .foregroundColor(.black)
          .overlay(
            RoundedRectangle(cornerRadius: 10)
              .stroke(
                Color(red: 142 / 255, green: 168 / 255, blue: 204 / 255).opacity(0.9), lineWidth: 1)
          )
          .padding(.horizontal)

        if searchWeatherForecastViewModel.state == .error {
          Text("Not a valid city").padding()
        }

        Spacer()
          .foregroundColor(.black)
        RoundedRectangle(cornerRadius: 10)
          .frame(height: 40).frame(maxWidth: 350).foregroundColor(
            Color(red: 142 / 255, green: 168 / 255, blue: 204 / 255).opacity(0.9)
          )
          .overlay(
            Text("Search")
              .foregroundColor(.black)
              .frame(height: 40).frame(maxWidth: 350)
          )
          .onTapGesture {
            Task {
              try? await searchWeatherForecastViewModel.getSearchWeatherForecastData()
              if searchWeatherForecastViewModel.state == .loaded {
                coordinator.showCityWeatherForecast()
              }
            }

          }

      }
      .padding()
      .frame(width: screenWidth)

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
    .navigationBarTitle(Text("Search City"), displayMode: .inline)
  }
}

#Preview {
  SearchWeatherForecastView()
    .environmentObject(Coordinator())
    .environmentObject(SearchWeatherForecastViewModel(networkManager: NetworkManager()))
}
