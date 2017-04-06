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

class YelpResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FiltersViewControllerDelegate {

    @IBOutlet weak var filterButton: UIBarButtonItem!
    @IBOutlet weak var mapButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!

    var userLocation = CLLocationCoordinate2D(latitude: 37.785771, longitude: -122.406165) //Default to SF
    var businesses = [Business]()
    var switchStates = [String : AnyObject]()
    var preferredFilters = PreferredFilters(dealOffered: false, distance: 0, sort: 0, categories: [])

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120

        KRProgressHUD.set(style: .blackColor)
        KRProgressHUD.set(activityIndicatorStyle: .color(.red, .red))
        KRProgressHUD.show()
        let locationManager = INTULocationManager.sharedInstance()
        locationManager.requestLocation(withDesiredAccuracy: .neighborhood, timeout: 5.0, delayUntilAuthorized: true) { (location, accuracy, status) in
            if location != nil {
                self.userLocation = (location?.coordinate)!
            }
            YelpService().search(withTerm: "Vegan", location: self.userLocation, sort: nil, categories: [], deals: nil, onSuccess: { results -> Void in
                self.businesses = results
                self.tableView.reloadData()
            }) { error -> Void in
                print(error)
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let filtersViewController = navigationController.topViewController as! YelpFiltersViewController
        filtersViewController.preferredFilters = preferredFilters
        filtersViewController.delegate = self
    }

    func filtersViewController(filtersViewController: YelpFiltersViewController, didUpdateFilters filters: PreferredFilters) {


//        YelpService().search(withTerm: "Vegan", location: self.userLocation, sort: filters.sort.map { SortType(rawValue: Int($0)) }!, categories: filters.categories, deals: filters.dealOffered, onSuccess: { results -> Void in
//            self.businesses = results
//            self.tableView.reloadData()
//        }) { error -> Void in
//            print(error)
//        }

        //Search here

    }

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { //CHECK this
        return businesses.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessViewCell", for: indexPath) as! BusinessViewCell
        cell.updateCell(withBusiness: businesses[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        KRProgressHUD.dismiss()
    }

    @IBAction func filterTapped(_ sender: UIBarButtonItem) {
    }
    @IBAction func mapTapped(_ sender: UIBarButtonItem) {
    }
}
