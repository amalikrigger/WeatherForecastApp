//
//  ImageView.swift
//  WeatherForecastApp
//
//  Created by Amali Krigger on 10/31/23.
//

import SwiftUI

struct ImageView: View {
    @ObservedObject private var imageViewModel: ImageViewModel
    init(urlString: String?) {
        imageViewModel = ImageViewModel(urlString: urlString, imageCache: ImageCache())
    }

    var body: some View {
        Image(uiImage: imageViewModel.image ?? UIImage())
        .resizable()
    }

}

#Preview {
    ImageView(urlString: "")
}
