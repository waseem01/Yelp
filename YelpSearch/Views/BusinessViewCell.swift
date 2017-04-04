//
//  BusinessViewCell.swift
//  YelpSearch
//
//  Created by Waseem Mohd on 4/4/17.
//  Copyright © 2017 Mohammed. All rights reserved.
//

import UIKit
import AFNetworking

class BusinessViewCell: UITableViewCell {

    @IBOutlet weak var businessImageView: UIImageView!
    @IBOutlet weak var ratingsImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!

    func updateCell(withBusiness business: Business) {
        self.businessImageView.setImageWith(URL(string: business.imageUrl)!)
        self.businessImageView.layer.cornerRadius = 3
        self.businessImageView.clipsToBounds = true
        self.ratingsImageView.setImageWith(URL(string: business.ratingUrl)!)
        self.nameLabel.text = business.name
        self.distanceLabel.text = formattedDistance(distance: business.distance)
        self.reviewsLabel.text =  business.reviewCount + " Reviews"
        self.addressLabel.text = business.address.joined(separator: ", ")
        self.categoriesLabel.text = formattedCategories(categoriesArray: business.categories)
    }

    private func formattedDistance(distance: String) -> String {
        let milesPerMeter = 0.000621371
        let distance = String(format: "%.2f mi", milesPerMeter * Double(distance)!)
        return distance
    }

    private func formattedCategories(categoriesArray: [[String]]) -> String {
        var categoryNames = [String]()
        for category in categoriesArray {
            categoryNames.append(category.first!)
        }
        return categoryNames.joined(separator: ", ")
    }
}
