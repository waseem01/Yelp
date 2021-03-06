//
//  Business.swift
//  YelpSearch
//
//  Created by Waseem Mohd on 4/4/17.
//  Copyright © 2017 Mohammed. All rights reserved.
//

import Unbox
import CoreLocation

struct Business: Unboxable {

    let imageUrl: String
    let name: String
    let address: [String]
    let ratingUrl: String
    let reviewCount: String
    let categories: [[String]]
    let distance: String
    let latitude: String
    let longitude: String
    let location: CLLocation

    init(unboxer: Unboxer) throws {
        self.imageUrl = try unboxer.unbox(key: "image_url")
        self.name = try unboxer.unbox(key: "name")
        self.address = try unboxer.unbox(keyPath: "location.display_address")
        self.ratingUrl = try unboxer.unbox(key: "rating_img_url")
        self.reviewCount = try unboxer.unbox(key: "review_count")
        self.categories = try unboxer.unbox(key: "categories")
        self.distance = try unboxer.unbox(key: "distance")
        self.latitude = try unboxer.unbox(keyPath: "location.coordinate.latitude")
        self.longitude = try unboxer.unbox(keyPath: "location.coordinate.longitude")
        self.location = CLLocation(latitude: Double(self.latitude)!, longitude: Double(self.longitude)!)
    }
}
