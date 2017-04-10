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
        styleNavigationBar()
    }

    // MARK: - Public Methods
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
        navigationItem.title = business.name
        addMapAnnotations()
    }

    // MARK: - Private Methods
    private func styleNavigationBar() {
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.topItem?.title = ""
            navigationBar.tintColor = UIColor.white
            let shadow = NSShadow()
            shadow.shadowColor = UIColor.gray.withAlphaComponent(0.5)
            shadow.shadowOffset = CGSize(width: 2, height: 2)
            shadow.shadowBlurRadius = 4;
            navigationBar.titleTextAttributes = [
                NSFontAttributeName : UIFont.boldSystemFont(ofSize: 18),
                NSForegroundColorAttributeName : UIColor.white,
                NSShadowAttributeName : shadow
            ]
        }
        businessView.layer.shadowOffset = CGSize(width: 0, height: 1)
        businessView.layer.shadowOpacity = 0.25
        businessView.layer.shadowRadius = 2
        updateBusinessView(business: business)
    }

    private func addMapAnnotations() {
        let annotation = MKPointAnnotation()
        annotation.coordinate = business.location.coordinate
        annotation.title = business.name
        annotation.subtitle = business.address.joined(separator: ", ")

        let geoCoder = CLGeocoder ()

        geoCoder.reverseGeocodeLocation(business.location, completionHandler: { (placemarks, error) -> Void in
            self.businessMapView.showAnnotations([annotation], animated: true)
        })
    }
}
