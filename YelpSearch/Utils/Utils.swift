//
//  Utils.swift
//  YelpSearch
//
//  Created by Waseem Mohd on 4/9/17.
//  Copyright © 2017 Mohammed. All rights reserved.
//

import Foundation

class Utils: NSObject {

    func formattedDistance(distance: String) -> String {
        let milesPerMeter = 0.000621371
        let distance = String(format: "%.2f mi", milesPerMeter * Double(distance)!)
        return distance
    }

    func formattedCategories(categoriesArray: [[String]]) -> String {
        var categoryNames = [String]()
        for category in categoriesArray {
            categoryNames.append(category.first!)
        }
        return categoryNames.joined(separator: ", ")
    }
}
