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
  @State var index = 0
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
            Text(
              index == 0
                ? "Tomorrow"
                : currentWeatherViewModel.dailyWeatherData?[index]?.dailyTime ?? "Tomorrow"
            )
            .font(.system(size: 40))
            .foregroundColor(.black)
            Spacer()
            HStack {
              ElevatedIconButton(
                iconName: "arrow.left", opacity: index == 0 ? 0.4 : 0.9,
                onTapGesture: {
                  if index != 0 {
                    index -= 1
                  }
                })
              ElevatedIconButton(
                iconName: "arrow.right", opacity: index == 4 ? 0.4 : 0.9,
                onTapGesture: {
                  if index < 4 {
                    index += 1
                  }
                })
            }
          }
          .padding(.leading, 20)
          .padding(.trailing)
          .padding(.top, 30)
          .frame(width: screenWidth)
          Text(
            currentWeatherViewModel.dailyWeatherData?[index]?.weather.first?.main
              ?? "Rainy and windy"
          )
          .foregroundColor(.black)
          .frame(width: screenWidth, alignment: .leading)
          .padding(.leading, 45)
          Spacer()
            HStack {
            VStack(alignment: .leading) {
              Spacer()
              ScalableText(
                alignment: .leading, height: 80, minSize: 80,
                text: (currentWeatherViewModel.dailyWeatherData?[index]?.formattedTemp) ?? "130°",
                widthFactor: 1)
              Spacer()
              ScalableText(
                alignment: .leading, height: 35, minSize: 40,
                text: currentWeatherViewModel.dailyWeatherData?[index]?.weather.first?.description
                  .capitalized ?? "Pretty warm", widthFactor: 5)
              Spacer()
              ScalableText(
                alignment: .leading, height: 20, minSize: 20,
                text:
                  "From \(currentWeatherViewModel.dailyWeatherData?[index]?.formattedTempMin ?? "180°") To: \(currentWeatherViewModel.dailyWeatherData?[index]?.formattedTempMax ?? "230°")",
                widthFactor: 5)
            }
            .padding(.leading, screenWidth * 0.06)
            .frame(width: screenWidth * 0.4, height: 172)
            Spacer()
            VStack(spacing: 11) {
              Spacer()
              VStack {
                Text(Image(systemName: "wind"))
                  .font(.system(size: 22))
                  .foregroundColor(.black)
                Text((currentWeatherViewModel.dailyWeatherData?[index]?.formattedWind) ?? "7km/h")
                  .foregroundColor(.black)
                  .bold()
                Text("Wind")
                  .foregroundColor(.black)
              }
              VStack {
                Text(Image(systemName: "drop"))
                  .font(.system(size: 22))
                  .foregroundColor(.black)
                Text((currentWeatherViewModel.dailyWeatherData?[index]?.formattedHumidity) ?? "36%")
                  .foregroundColor(.black)
                  .bold()
                Text("Humidity")
                  .foregroundColor(.black)
              }
            }
            .frame(width: screenWidth * 0.3, height: 140)
            Spacer()
              Image(systemName: Constants.getWeatherIconString(icon: currentWeatherViewModel.dailyWeatherData?[index]?.weather.first?.icon ?? "50d") ?? "sun.max.fill")
                  .resizable()
                  .frame(width: screenWidth * 0.2, height: screenWidth * 0.2)
                  .padding(.trailing)
          }
          .frame(width: screenWidth, height: 200)
          Spacer()
          FiveDayWeatherForecastView()
            .padding(.bottom, 30)
        }
        .frame(height: screenHeight * 0.875)
      }

      .refreshable {
        currentWeatherViewModel.getHardCodedLocation()
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
      },
      trailing: Button(action: {
        // Handle additional actions on the right
      }) {
        Image(systemName: "ellipsis")
          .foregroundColor(.black)
      }
    )
    .navigationBarTitle("Next 5 Days", displayMode: .inline)

  }
}

#Preview {
  DailyWeatherForecastView()
    .environmentObject(CurrentWeatherViewModel(networkManager: NetworkManager()))
}
