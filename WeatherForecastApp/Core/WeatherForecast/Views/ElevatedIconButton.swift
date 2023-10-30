//
//  ElevatedIconButton.swift
//  WeatherForecastApp
//
//  Created by Amali Krigger on 10/29/23.
//

import SwiftUI

struct ElevatedIconButton: View {
  let iconName: String
  let opacity: CGFloat
  var body: some View {
    RoundedRectangle(cornerRadius: 20)
      .frame(width: 50, height: 50)
      .foregroundColor(
        Color(red: 142 / 255, green: 168 / 255, blue: 204 / 255).opacity(opacity)
      )
      .overlay(
        Image(systemName: iconName)
          .foregroundColor(.white)
          .onTapGesture {
            print("clicked")
          }
      )
  }
}

#Preview {
  ElevatedIconButton(iconName: "arrow.left", opacity: 0.5)
}
