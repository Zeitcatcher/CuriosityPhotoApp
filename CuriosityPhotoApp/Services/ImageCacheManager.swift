//
//  ImageCacheManager.swift
//  CuriosityPhotoApp
//
//  Created by Arseniy Oksenoyt on 10/14/23.
//

import UIKit

class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {}
}
