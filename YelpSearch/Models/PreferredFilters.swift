//
//  PreferredFilters.swift
//  YelpSearch
//
//  Created by Waseem Mohd on 4/7/17.
//  Copyright © 2017 Mohammed. All rights reserved.
//

import Foundation

class PreferredFilters {

    var dealOffered: Bool?
    var distance: NSNumber?
    var sort: Int?
    var categories: [String]?

    init(dealOffered: Bool, distance: NSNumber, sort: Int, categories: [String]) {
        self.dealOffered = dealOffered
        self.distance = distance
        self.sort = sort
        self.categories = categories
    }
}
