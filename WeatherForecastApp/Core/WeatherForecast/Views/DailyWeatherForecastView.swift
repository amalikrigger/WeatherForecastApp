//
//  DailyWeatherForecast.swift
//  WeatherForecastApp
//
//  Created by Amali Krigger on 10/29/23.
//

import SwiftUI

struct DailyWeatherForecastView: View {
  @Environment(\.presentationMode) var presentationMode
  @EnvironmentObject var currentWeatherViewModel: CurrentWeatherViewModel
  let screenWidth = UIScreen.main.bounds.size.width
  let screenHeight = UIScreen.main.bounds.size.height

  var body: some View {
    ZStack {
      Image("weather_background_3")
        .resizable()
        .aspectRatio(contentMode: .fill)
        .edgesIgnoringSafeArea( /*@START_MENU_TOKEN@*/.all /*@END_MENU_TOKEN@*/)
        .blur(radius: 4)

      Color.white.opacity(0.2)
        .edgesIgnoringSafeArea( /*@START_MENU_TOKEN@*/.all /*@END_MENU_TOKEN@*/)

      ScrollView(.vertical, showsIndicators: false) {
        VStack {
          HStack {
            Text("Tomorrow")
              .font(.system(size: 40))
            Spacer()
            HStack {
              ElevatedIconButton(iconName: "arrow.left", opacity: 0.4)
              ElevatedIconButton(iconName: "arrow.right", opacity: 0.9)
            }
          }
          .padding(.horizontal)
          .padding(.top, 30)
          .frame(width: screenWidth)
          Text("Rainy and windy")
            .frame(width: screenWidth, alignment: .leading)
            .padding(.leading, 40)
          Spacer()
          HStack {
            VStack(alignment: .leading) {
              Text("13°")
                .font(.system(size: 90))
              Text("Pretty warm")
                .font( /*@START_MENU_TOKEN@*/.title /*@END_MENU_TOKEN@*/)
              Spacer().frame(height: 10)
              Text("From 18° To: 23°")
            }
            .padding(.leading, 23)
            Spacer()
            VStack(spacing: 11) {
              Spacer()
              VStack {
                Text(Image(systemName: "wind"))
                  .font(.system(size: 22))
                Text("7km/h")
                  .foregroundColor(.black)
                  .bold()
                Text("Wind")
                  .foregroundColor(.black)
              }
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
            .frame(height: 150)
            Spacer()
            WeatherIcon(width: 120, height: 50)
              .padding(.trailing, 5)
          }
          .frame(width: screenWidth, height: 150)
          Spacer()
          FiveDayWeatherForecastView()
        }
        .frame(height: screenHeight * 0.875)
      }

      .refreshable {
        print("Refresh")
      }

    }
    .navigationBarBackButtonHidden()
    .navigationBarItems(
      leading: Button(action: {
        self.presentationMode.wrappedValue.dismiss()
      }) {
        Image(systemName: "chevron.left")
          .bold()
          .foregroundColor(.white)
      },
      trailing: Button(action: {
        // Handle additional actions on the right
      }) {
        Image(systemName: "ellipsis")
          .foregroundColor(.white)
      }
    )
    .navigationBarTitle("Next 5 Days", displayMode: .inline)

  }
}

#Preview {
  DailyWeatherForecastView()
    .environmentObject(CurrentWeatherViewModel(networkManager: NetworkManager()))
}
