//
//  ScalableText.swift
//  WeatherForecastApp
//
//  Created by Amali Krigger on 10/30/23.
//

import SwiftUI

struct ScalableText: View {
  @State private var dynamicFontSize: CGFloat = 60
  let text: String
  var body: some View {
    GeometryReader { geometry in
      Text(text)
        .font(.system(size: dynamicFontSize))
        .minimumScaleFactor(0.5)
        .lineLimit(1)
        .frame(width: geometry.size.width, alignment: .center)
        .onAppear {
          let maxSize = min(40, geometry.size.width / 10)
          dynamicFontSize = maxSize
        }
    }.frame(height: 45)
  }
}

#Preview {
  ScalableText(text: "America/Chicago")
}
