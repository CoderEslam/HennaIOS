//
//  ImageService.swift
//  iosApp
//
//  Created by Eslam Ghazy on 13/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import Alamofire

class LoadingImageService {
    static let imageCache = NSCache<NSString, UIImage>()

    func loadImage(from url: String) -> AnyPublisher<UIImage?, Never> {
        if let cachedImage = LoadingImageService.imageCache.object(forKey: url as NSString) {
            return Just(cachedImage).eraseToAnyPublisher()
        }

        return Future<UIImage?, Never> { promise in
            AF.request(url).responseData { response in
                switch response.result {
                case .success(let data):
                    if let image = UIImage(data: data) {
                        LoadingImageService.imageCache.setObject(image, forKey: url as NSString)
                        promise(.success(image))
                    } else {
                        promise(.success(nil))
                    }
                case .failure:
                    promise(.success(nil))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
