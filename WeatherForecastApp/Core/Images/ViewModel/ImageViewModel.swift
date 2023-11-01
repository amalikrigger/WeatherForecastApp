//
//  ImageViewModel.swift
//  WeatherForecastApp
//
//  Created by Amali Krigger on 10/31/23.
//

import SwiftUI

class ImageViewModel: ObservableObject {
    @Published var image: UIImage?
    let imageCache: ImageCacheHelper
    init(urlString: String?, imageCache: ImageCacheHelper) {
        self.imageCache = imageCache
        loadImage(urlString: urlString)
    }

    func loadImage(urlString: String?) {
        guard let urlString = urlString else {
            return
        }
        if let cachedImage = imageCache.getImage(url: urlString) {
            image = cachedImage
            return
        }
        else {
            loadImageAsync(urlString: urlString)
        }
    }

    func loadImageAsync(urlString: String) {
        Task {
            guard let url = URL(string: urlString) else {
                return
            }
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
                        self.image = image
                        self.imageCache.setImage(image: image, url: url.absoluteString)
                    }
                }
            }
            catch {
                print(error)
            }
        }
    }
}
