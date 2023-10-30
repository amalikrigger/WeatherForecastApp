//
//  ScalableText.swift
//  WeatherForecastApp
//
//  Created by Amali Krigger on 10/30/23.
//

import SwiftUI

struct ScalableText: View {
  @State private var dynamicFontSize: CGFloat = 60
  let alignment: Alignment
  let height: Double
  let minSize: Double
  let text: String
  let widthFactor: Double
  var body: some View {
    GeometryReader { geometry in
      Text(text)
        .font(.system(size: dynamicFontSize))
        .foregroundColor(.black)
        .minimumScaleFactor(0.5)
        .lineLimit(1)
        .frame(width: geometry.size.width, alignment: alignment)
        .onAppear {
          let maxSize = min(minSize, geometry.size.width / widthFactor)
          dynamicFontSize = maxSize
        }
    }.frame(height: height)
  }
}

#Preview {
  ScalableText(
    alignment: .center, height: 45, minSize: 40, text: "America/Chicago", widthFactor: 10)
}
