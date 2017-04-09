//
//  YelpDetailsViewController.swift
//  YelpSearch
//
//  Created by Waseem Mohd on 4/9/17.
//  Copyright © 2017 Mohammed. All rights reserved.
//

import UIKit
import MapKit
import AFNetworking

class YelpDetailsViewController: UIViewController {

    @IBOutlet weak var businessMapView: MKMapView!
    @IBOutlet weak var businessView: BusinessView!
    @IBOutlet weak var businessImageView: UIImageView!
    @IBOutlet weak var ratingsImageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    var business: Business!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let navigationBar = navigationController?.navigationBar {
            navigationBar.topItem?.title = ""
            navigationBar.tintColor = UIColor.white
        }
        businessView.layer.shadowOffset = CGSize(width: 0, height: 1)
        businessView.layer.shadowOpacity = 0.25
        businessView.layer.shadowRadius = 2
        updateBusinessView(business: business)
    }

    func updateBusinessView(business: Business) {
        businessImageView.setImageWith(URL(string: business.imageUrl)!)
        businessImageView.layer.cornerRadius = 3
        businessImageView.clipsToBounds = true
        ratingsImageView.setImageWith(URL(string: business.ratingUrl)!)
        nameLabel.text = business.name
        distanceLabel.text = Utils().formattedDistance(distance: business.distance)
        reviewsLabel.text =  business.reviewCount + " Reviews"
        addressLabel.text = business.address.joined(separator: ", ")
        categoriesLabel.text = Utils().formattedCategories(categoriesArray: business.categories)
    }
}
