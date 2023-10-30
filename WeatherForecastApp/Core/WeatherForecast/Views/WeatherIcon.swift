//
//  WeatherIcon.swift
//  WeatherForecastApp
//
//  Created by Amali Krigger on 10/29/23.
//

import SwiftUI

struct WeatherIcon: View {

  let width: CGFloat
  let height: CGFloat

  var body: some View {
    Image("cloudy_icon")
      .resizable()
      .aspectRatio(contentMode: .fill)
      .frame(width: width, height: height)
  }
}

#Preview {
  WeatherIcon(width: 200, height: 100)
}
