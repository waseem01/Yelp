//
//  YelpResultsViewController.swift
//  YelpSearch
//
//  Created by Waseem Mohd on 4/4/17.
//  Copyright © 2017 Mohammed. All rights reserved.
//

import UIKit
import CoreLocation
import INTULocationManager
import KRProgressHUD

class YelpResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, FiltersViewControllerDelegate {

    @IBOutlet weak var filterButton: UIBarButtonItem!
    @IBOutlet weak var mapButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!

    var userLocation = CLLocationCoordinate2D(latitude: 37.785771, longitude: -122.406165) //Default to SF
    var businesses = [Business]()
    var filteredBusinesses = [Business]()
    var switchStates = [String : AnyObject]()
    var preferredFilters = PreferredFilters(dealOffered: false, distance: 0, sort: 0, categories: [])

    var searchTerm: String = "" {
        didSet {
            performSearch(withTerm: searchTerm)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        searchBar.delegate = self

        let locationManager = INTULocationManager.sharedInstance()
        locationManager.requestLocation(withDesiredAccuracy: .neighborhood, timeout: 5.0, delayUntilAuthorized: true) { (location, accuracy, status) in
            if location != nil {
                self.userLocation = (location?.coordinate)!
            }
            self.performSearch(withTerm: "")
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let filtersViewController = navigationController.topViewController as! YelpFiltersViewController
        filtersViewController.preferredFilters = preferredFilters
        filtersViewController.delegate = self
    }

    // MARK: - FiltersViewControllerDelegate
    func filtersViewController(filtersViewController: YelpFiltersViewController, didUpdateFilters filters: PreferredFilters) {
        performSearch(withTerm: searchTerm, deals: filters.dealOffered, distance: filters.distance, sort: filters.sort, categories: filters.categories)
    }

    // MARK: - Private Methods
    private func performSearch(withTerm term: String) {
        performSearch(withTerm: term, deals: nil, distance: nil, sort: nil, categories: nil)
    }

    private func performSearch(withTerm term: String, deals: Bool?, distance: NSNumber?, sort: Int?, categories: [String]?) {
        KRProgressHUD.set(style: .blackColor)
        KRProgressHUD.set(activityIndicatorStyle: .color(.red, .red))
        KRProgressHUD.show()
        YelpService().search(withTerm: term, location: self.userLocation, deals: deals, distance: distance, sort: sort, categories: categories, onSuccess: { results -> Void in
            self.businesses = results
            self.filteredBusinesses = self.businesses
            self.tableView.reloadData()
            self.mapView.updateMap(businesses: self.filteredBusinesses)
        }) { error -> Void in
            KRProgressHUD.dismiss()
            print(error)
        }
    }

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { //CHECK this
        return filteredBusinesses.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        cell.updateCell(withBusiness: filteredBusinesses[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        KRProgressHUD.dismiss()
    }

    // MARK: - UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchTerm = searchBar.text!
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count == 0 {
            searchTerm = ""
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        performSearch(withTerm: "")
    }

    @IBAction func mapTapped(_ sender: UIBarButtonItem) {
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        UIView.transition(with: self.view, duration: 1.0, options: transitionOptions, animations: {
            self.mapView.isHidden = !self.mapView.isHidden
        })
        sender.title = (self.mapView.isHidden ? "Map" : "List")
    }

    //MARK: Properties
    private lazy var mapView: MapView = {
        let location = CLLocation(latitude: self.userLocation.latitude, longitude: self.userLocation.longitude)
//        let locations = self.filteredBusinesses.flatMap{ $0.location }
        let view = MapView(userLocation: location, businesses: self.filteredBusinesses)
        view.frame = self.view.bounds
        view.backgroundColor = UIColor.white
        view.isHidden = true
        self.view.addSubview(view)
        return view
    }()
}
