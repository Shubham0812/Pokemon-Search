//
//  ImageCache.swift
//  Realm-Tutorial
//
//  Created by Shubham Singh on 02/03/21.
//

import Foundation

struct ImageCache {
    static var shared: ImageCache = {
        return ImageCache()
    }()
    
    var imageMap: [Int : Data] = [:]
}
