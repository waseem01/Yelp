//
//  File.swift
//  YelpSearch
//
//  Created by Waseem Mohd on 4/6/17.
//  Copyright © 2017 Mohammed. All rights reserved.
//

import Foundation

enum ControlType {
    case `switch`
    case radio(name: String)
}

enum FilterType {
    case deals
    case distance
    case sort
    case category(name: String)
}

struct FilterItem {

    let name: String?
    let type: FilterType
    let value: AnyObject
}

class Filter {

    let title: String?
    let type: ControlType
    let items: [FilterItem]
    let isExpandable: Bool
    var isExpanded: Bool
    let minNumOfRows: Int

    var visibleRowCount: Int {
        get {
            switch type {
            case .switch:
                if (isExpandable) {
                    return isExpanded ? items.count : minNumOfRows
                }

                return items.count

            case .radio:
                return isExpanded ? items.count : 0
            }
        }
    }

    init(title: String?, type: ControlType, items: [FilterItem],
         minNumOfRows: Int, isExpandable: Bool = true, isExpanded: Bool = false) {
        self.title = title
        self.type = type
        self.items = items
        self.minNumOfRows = minNumOfRows
        self.isExpandable = isExpandable
        self.isExpanded = isExpanded
    }

    convenience init(title: String?, type: ControlType, items: [FilterItem], isExpandable: Bool = false, isExpanded: Bool = false) {
        self.init(title: title, type: type, items: items, minNumOfRows: 3, isExpandable: false, isExpanded: isExpanded)
    }
}
