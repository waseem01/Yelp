//
//  YelpFiltersViewController.swift
//  YelpSearch
//
//  Created by Waseem Mohd on 4/6/17.
//  Copyright © 2017 Mohammed. All rights reserved.
//

import UIKit

protocol FiltersViewControllerDelegate {
    func filtersViewController(filtersViewController: YelpFiltersViewController, didUpdateFilters filters: PreferredFilters)
}

class YelpFiltersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SwitchCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    var preferredFilters: PreferredFilters?
    var filters: [Filter]!
    var delegate: FiltersViewControllerDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension

        filters = Filters.defaultFilters
    }

    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func searchTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)

        delegate?.filtersViewController(filtersViewController: self, didUpdateFilters: preferredFilters!)
    }

    //MARK: UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return filters.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return filters[section].title
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let filter = filters[section]

        switch filter.type {
        case .switch:
            return filter.visibleRowCount + (filter.isExpandable ? 1 : 0)

        case .radio:
            return (filter.isExpanded ? filter.items.count : 1)
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let filter = filters[indexPath.section]
        var isActive = false

        switch filter.type {
        case .switch:
            if indexPath.row == filter.visibleRowCount {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ExpandCell")!
                if filter.visibleRowCount > filter.minNumOfRows {
                    cell.textLabel?.text = "See Top"
                } else {
                    cell.textLabel?.text = "See All"
                }
                return cell
            }

            if indexPath.section == 0 {
                isActive = (preferredFilters?.dealOffered)!
            } else {
                isActive = (preferredFilters?.categories?.contains(Filters.categories[(indexPath.row)]["value"]!))!
            }

            let filterItem = filter.items[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell") as! SwitchCell
            cell.delegate = self
            cell.updateCell(filterType: filterItem.type, switchTitle: filterItem.name!, isActive: isActive)

            return cell

        case .radio( _):
            let filterItem = filter.items[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "RadioCell") as! RadioCell
            cell.radioCellLabel.text = filterItem.name!
            if (indexPath.row != 0)  {
                cell.carretImageView.isHidden = true
            } else {
                cell.carretImageView.isHidden = false
            }

            switch filterItem.type { //TODO: This can be better?
            case .distance:
                if preferredFilters?.distance != 0 && indexPath.row == 0 {
                    let distanceNames = Filters.distances.flatMap { $0["name"] as? String }
                    let distanceValues = Filters.distances.flatMap { $0["value"] as? NSNumber }
                    let index = distanceValues.index(of: (preferredFilters?.distance)!)
                    cell.radioCellLabel.text = distanceNames[index!]
                }
            case .sort:
                if preferredFilters?.sort != 0 && indexPath.row == 0 {
                    let sortNames = Filters.sorts.flatMap { $0["name"] as? String }
                    let sortValues = Filters.sorts.flatMap { $0["value"] as? Int }
                    let index = sortValues.index(of: (preferredFilters?.sort)!)
                    cell.radioCellLabel.text = sortNames[index!]
                }
            default:
                break
            }

            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let filter = filters[indexPath.section]
        let filterItem = filter.items[indexPath.section]
        var sections = IndexSet(integer: 0)
        let cell = tableView.cellForRow(at: indexPath)

        switch filterItem.type {
        case .distance:
            preferredFilters?.distance = Filters.distances[indexPath.row]["value"] as? NSNumber
            sections = IndexSet(integer: indexPath.section)
        case .sort:
            preferredFilters?.sort = Filters.sorts[indexPath.row]["value"] as? Int
            sections = IndexSet(integer: indexPath.section)
        default:
            break
        }
        filter.isExpanded = !filter.isExpanded

        if cell?.reuseIdentifier != "ExpandCell" {
            UIView.transition(with: self.view,
                              duration: 0.25,
                              options: .curveLinear,
                              animations: { () -> Void in
                                self.tableView.reloadSections(sections, with: .none)
            }, completion: nil)
        } else {
            self.tableView.reloadData()
        }
    }

    func switchCell(switchCell: SwitchCell, didChange active: Bool) {
        let indexPath = tableView.indexPath(for: switchCell)
        let filter = filters[(indexPath?.section)!]
        let filterItem = filter.items[(indexPath?.row)!]
        switch filterItem.type {
        case .deals:
            preferredFilters?.dealOffered = active
        default:
            if active {
                let category = Filters.categories[(indexPath?.row)!]["value"]
                preferredFilters?.categories?.append(category!)
            } else {
                let category = Filters.categories[(indexPath?.row)!]["value"]
                let categoryIndex = preferredFilters?.categories?.index(of: category!)
                preferredFilters?.categories?.remove(at: categoryIndex!)
            }
        }
    }
}
