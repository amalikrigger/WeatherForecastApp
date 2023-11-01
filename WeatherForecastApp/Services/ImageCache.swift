//
//  Cache.swift
//  WeatherForecastApp
//
//  Created by Amali Krigger on 10/31/23.
//

import SwiftUI

protocol ImageCacheHelper {
    func getImage(url: String) -> UIImage?
    func setImage(image: UIImage?, url: String)
}
class ImageCache: ImageCacheHelper {
    private let cache = NSCache<NSString, UIImage>()
    func getImage(url: String) -> UIImage? {
        return cache.object(forKey: url as NSString)
    }

    func setImage(image: UIImage?, url: String) {
        if let image = image {
            cache.setObject(image, forKey: url as NSString)
        }
    }
}
