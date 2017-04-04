//
//  YelpResultsViewController.swift
//  YelpSearch
//
//  Created by Waseem Mohd on 4/4/17.
//  Copyright © 2017 Mohammed. All rights reserved.
//

import UIKit

class YelpResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var filterButton: UIBarButtonItem!
    @IBOutlet weak var mapButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    var businesses = [Business]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120  

        let yelp = YelpService()
        yelp.search(withTerm: "Vegan", sort: nil, categories: [], deals: nil, onSuccess: { results -> Void in
            self.businesses = results
            self.tableView.reloadData()
        }) { error -> Void in
            print(error)
        }
    }


    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessViewCell") as! BusinessViewCell
        cell.updateCell(withBusiness: businesses[indexPath.row])
        return cell
    }

    @IBAction func filterTapped(_ sender: UIBarButtonItem) {
    }
    @IBAction func mapTapped(_ sender: UIBarButtonItem) {
    }
    // MARK: - Navigation

}
