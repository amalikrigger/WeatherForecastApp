//
//  WeatherImageView.swift
//  WeatherForecastApp
//
//  Created by Amali Krigger on 10/31/23.
//

import SwiftUI

struct WeatherImageView: View {
    let icon: String
    let height: Double?
    let width: Double?
    var body: some View {
        ImageView(urlString: Constants.getWeatherIcon(icon: icon))
            .frame(width: width ?? 200, height: height ?? 200)
    }
}

#Preview {
    WeatherImageView(icon: "", height: 200, width: 200)
}
