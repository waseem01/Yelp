//
//  BusinessCell.swift
//  YelpSearch
//
//  Created by Waseem Mohd on 4/4/17.
//  Copyright © 2017 Mohammed. All rights reserved.
//

import UIKit
import AFNetworking

class BusinessCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
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
        self.distanceLabel.text = Utils().formattedDistance(distance: business.distance)
        self.reviewsLabel.text =  business.reviewCount + " Reviews"
        self.addressLabel.text = business.address.joined(separator: ", ")
        self.categoriesLabel.text = Utils().formattedCategories(categoriesArray: business.categories)

        containerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        containerView.layer.shadowOpacity = 0.25
        containerView.layer.shadowRadius = 2
    }
}
