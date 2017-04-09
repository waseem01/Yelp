//
//  MapView.swift
//  YelpSearch
//
//  Created by Waseem Mohd on 4/8/17.
//  Copyright © 2017 Mohammed. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapView: UIView, MKMapViewDelegate {
    var mapView: MKMapView!
    var userLocation: CLLocation!
    var businesses: [Business]!
    let regionRadius: CLLocationDistance = 2000

    //MARK: - Initializers
    init(userLocation: CLLocation, businesses: [Business]) {
        super.init(frame: CGRect.zero)
        self.userLocation = userLocation
        self.businesses = businesses
        setupMapView()
        setupConstraints()
        updateMap(businesses: businesses)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateMap(businesses: [Business]) {
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
        for (business) in businesses {
            let address = business.address.joined(separator: ", ")
            let businessPin = BusinessPin(title: business.name, subtitle: address, location: business.location)
            self.mapView.addAnnotation(businessPin)
        }
    }

    //MARK: - Private methods
    private func setupMapView() {
        mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.delegate = self
        mapView.layer.borderColor = UIColor.gray.cgColor
        mapView.layer.borderWidth = 1.0
        mapView.accessibilityLabel = "MapView"
        addSubview(mapView)
        centerMapOnLocation(userLocation)

//        let businessPin = BusinessPin(title: "Hello", subtitle: "World", location: userLocation)
//        self.mapView.addAnnotation(businessPin)
    }

    private func centerMapOnLocation(_ location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    private func setupConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[mapView]-5-|", options: [], metrics: nil, views: ["mapView" : mapView])
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[mapView]-5-|", options: [], metrics: nil, views: ["mapView" : mapView])
        NSLayoutConstraint.activate(constraints)
    }
}

class BusinessPin: NSObject, MKAnnotation {

    let coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?

    init(title: String, subtitle: String, location: CLLocation) {
        self.coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        self.title = title
        self.subtitle = subtitle
    }
}
