//
//  Filters.swift
//  YelpSearch
//
//  Created by Waseem Mohd on 4/6/17.
//  Copyright © 2017 Mohammed. All rights reserved.
//

import Foundation

struct Filters {

    static let defaultFilters1: [Filter] = [
        Filter(
            title: "",
            type: .switch,
            items: [
                FilterItem(
                    name: Filters.deal["name"] as? String,
                    type: .deals,
                    value: true as AnyObject
                )
            ]
        ),
        Filter(
            title: "Distance",
            type: .radio(name: "distance"),
            items: distances.map {item in
                return FilterItem(
                    name: item["name"] as? String,
                    type: .distance,
                    value: item["label"] as AnyObject
                )
            },
            isExpandable: true
        ),
        Filter(
            title: "Sort by",
            type: .radio(name: "sort"),
            items: sorts.map {item in
                return FilterItem(
                    name: item["name"] as? String,
                    type: .sort,
                    value: item["label"] as AnyObject
                )
            },
            isExpandable: true
        ),
        Filter(
            title: "Category",
            type: .switch,
            items: categories.map {item in
                return FilterItem(
                    name: item["name"],
                    type: .category(name: item["value"]!),
                    value: true as AnyObject
                )
            }
        )
    ]

    static let defaultFilters: [Filter] = [
        Filter(
            title: nil,
            type: .switch,
            items: [
                FilterItem(
                    name: Filters.deal["name"] as? String,
                    type: .deals,
                    value: true as AnyObject
                )
            ]
        ),

        Filter(
            title: "Distance",
            type: .radio(name: "distance"),
            items: distances.map {item in
                return FilterItem(
                    name: item["name"] as? String,
                    type: .distance,
                    value: item["label"] as AnyObject
                )
            },
            isExpandable: true
        ),

        Filter(
            title: "Sort by",
            type: .radio(name: "sort"),
            items: sorts.map {item in
                return FilterItem(
                    name: item["name"] as? String,
                    type: .sort,
                    value: item["label"] as AnyObject
                )
            },
            isExpandable: true
        ),

        Filter(
            title: "Category",
            type: .switch,
            items: categories.map {item in
                return FilterItem(
                    name: item["name"],
                    type: .category(name: item["value"]!),
                    value: true as AnyObject
                )
            },
            minNumOfRows: 3,
            isExpandable: true
        )
    ]

    static let deal: [String: AnyObject] = [
        "name": "Offering a Deal" as AnyObject,
        "value": true as AnyObject
    ]

    static let distances: [[String: AnyObject]] = [
        ["name": "Auto" as AnyObject, "value": 0 as AnyObject],
        ["name": "0.3 miles" as AnyObject, "value": 482.8032 as AnyObject],
        ["name": "1 mile" as AnyObject, "value": 1609.344 as AnyObject],
        ["name": "5 miles" as AnyObject, "value": 8046.720 as AnyObject],
        ["name": "20 miles" as AnyObject, "value": 32186.88 as AnyObject]
    ]

    static let sorts:[[String: AnyObject]] = [
        ["name": "Best matched" as AnyObject, "value": 0 as AnyObject],
        ["name": "Distance" as AnyObject, "value": 1 as AnyObject],
        ["name": "High rated" as AnyObject, "value": 2 as AnyObject]
    ]

    static let categories: [[String: String]] = [
        ["name": "Afghan", "value": "afghani"],
        ["name": "African", "value": "african"],
        ["name": "American, New", "value": "newamerican"],
        ["name": "American, Traditional", "value": "tradamerican"],
        ["name": "Arabian", "value": "arabian"],
        ["name": "Argentine", "value": "argentine"],
        ["name": "Armenian", "value": "armenian"],
        ["name": "Asian Fusion", "value": "asianfusion"],
        ["name": "Asturian", "value": "asturian"],
        ["name": "Australian", "value": "australian"],
        ["name": "Austrian", "value": "austrian"],
        ["name": "Baguettes", "value": "baguettes"],
        ["name": "Bangladeshi", "value": "bangladeshi"],
        ["name": "Barbeque", "value": "bbq"],
        ["name": "Basque", "value": "basque"],
        ["name": "Bavarian", "value": "bavarian"],
        ["name": "Beer Garden", "value": "beergarden"],
        ["name": "Beer Hall", "value": "beerhall"],
        ["name": "Beisl", "value": "beisl"],
        ["name": "Belgian", "value": "belgian"],
        ["name": "Bistros", "value": "bistros"],
        ["name": "Black Sea", "value": "blacksea"],
        ["name": "Brasseries", "value": "brasseries"],
        ["name": "Brazilian", "value": "brazilian"],
        ["name": "Breakfast & Brunch", "value": "breakfast_brunch"],
        ["name": "British", "value": "british"],
        ["name": "Buffets", "value": "buffets"],
        ["name": "Bulgarian", "value": "bulgarian"],
        ["name": "Burgers", "value": "burgers"],
        ["name": "Burmese", "value": "burmese"],
        ["name": "Cafes", "value": "cafes"],
        ["name": "Cafeteria", "value": "cafeteria"],
        ["name": "Cajun/Creole", "value": "cajun"],
        ["name": "Cambodian", "value": "cambodian"],
        ["name": "Canadian", "value": "New)"],
        ["name": "Canteen", "value": "canteen"],
        ["name": "Caribbean", "value": "caribbean"],
        ["name": "Catalan", "value": "catalan"],
        ["name": "Chech", "value": "chech"],
        ["name": "Cheesesteaks", "value": "cheesesteaks"],
        ["name": "Chicken Shop", "value": "chickenshop"],
        ["name": "Chicken Wings", "value": "chicken_wings"],
        ["name": "Chilean", "value": "chilean"],
        ["name": "Chinese", "value": "chinese"],
        ["name": "Comfort Food", "value": "comfortfood"],
        ["name": "Corsican", "value": "corsican"],
        ["name": "Creperies", "value": "creperies"],
        ["name": "Cuban", "value": "cuban"],
        ["name": "Curry Sausage", "value": "currysausage"],
        ["name": "Cypriot", "value": "cypriot"],
        ["name": "Czech", "value": "czech"],
        ["name": "Czech/Slovakian", "value": "czechslovakian"],
        ["name": "Danish", "value": "danish"],
        ["name": "Delis", "value": "delis"],
        ["name": "Diners", "value": "diners"],
        ["name": "Dumplings", "value": "dumplings"],
        ["name": "Eastern European", "value": "eastern_european"],
        ["name": "Ethiopian", "value": "ethiopian"],
        ["name": "Fast Food", "value": "hotdogs"],
        ["name": "Filipino", "value": "filipino"],
        ["name": "Fish & Chips", "value": "fishnchips"],
        ["name": "Fondue", "value": "fondue"],
        ["name": "Food Court", "value": "food_court"],
        ["name": "Food Stands", "value": "foodstands"],
        ["name": "French", "value": "french"],
        ["name": "French Southwest", "value": "sud_ouest"],
        ["name": "Galician", "value": "galician"],
        ["name": "Gastropubs", "value": "gastropubs"],
        ["name": "Georgian", "value": "georgian"],
        ["name": "German", "value": "german"],
        ["name": "Giblets", "value": "giblets"],
        ["name": "Gluten-Free", "value": "gluten_free"],
        ["name": "Greek", "value": "greek"],
        ["name": "Halal", "value": "halal"],
        ["name": "Hawaiian", "value": "hawaiian"],
        ["name": "Heuriger", "value": "heuriger"],
        ["name": "Himalayan/Nepalese", "value": "himalayan"],
        ["name": "Hong Kong Style Cafe", "value": "hkcafe"],
        ["name": "Hot Dogs", "value": "hotdog"],
        ["name": "Hot Pot", "value": "hotpot"],
        ["name": "Hungarian", "value": "hungarian"],
        ["name": "Iberian", "value": "iberian"],
        ["name": "Indian", "value": "indpak"],
        ["name": "Indonesian", "value": "indonesian"],
        ["name": "International", "value": "international"],
        ["name": "Irish", "value": "irish"],
        ["name": "Island Pub", "value": "island_pub"],
        ["name": "Israeli", "value": "israeli"],
        ["name": "Italian", "value": "italian"],
        ["name": "Japanese", "value": "japanese"],
        ["name": "Jewish", "value": "jewish"],
        ["name": "Kebab", "value": "kebab"],
        ["name": "Korean", "value": "korean"],
        ["name": "Kosher", "value": "kosher"],
        ["name": "Kurdish", "value": "kurdish"],
        ["name": "Laos", "value": "laos"],
        ["name": "Laotian", "value": "laotian"],
        ["name": "Latin American", "value": "latin"],
        ["name": "Live/Raw Food", "value": "raw_food"],
        ["name": "Lyonnais", "value": "lyonnais"],
        ["name": "Malaysian", "value": "malaysian"],
        ["name": "Meatballs", "value": "meatballs"],
        ["name": "Mediterranean", "value": "mediterranean"],
        ["name": "Mexican", "value": "mexican"],
        ["name": "Middle Eastern", "value": "mideastern"],
        ["name": "Milk Bars", "value": "milkbars"],
        ["name": "Modern Australian", "value": "modern_australian"],
        ["name": "Modern European", "value": "modern_european"],
        ["name": "Mongolian", "value": "mongolian"],
        ["name": "Moroccan", "value": "moroccan"],
        ["name": "New Zealand", "value": "newzealand"],
        ["name": "Night Food", "value": "nightfood"],
        ["name": "Norcinerie", "value": "norcinerie"],
        ["name": "Open Sandwiches", "value": "opensandwiches"],
        ["name": "Oriental", "value": "oriental"],
        ["name": "Pakistani", "value": "pakistani"],
        ["name": "Parent Cafes", "value": "eltern_cafes"],
        ["name": "Parma", "value": "parma"],
        ["name": "Persian/Iranian", "value": "persian"],
        ["name": "Peruvian", "value": "peruvian"],
        ["name": "Pita", "value": "pita"],
        ["name": "Pizza", "value": "pizza"],
        ["name": "Polish", "value": "polish"],
        ["name": "Portuguese", "value": "portuguese"],
        ["name": "Potatoes", "value": "potatoes"],
        ["name": "Poutineries", "value": "poutineries"],
        ["name": "Pub Food", "value": "pubfood"],
        ["name": "Rice", "value": "riceshop"],
        ["name": "Romanian", "value": "romanian"],
        ["name": "Rotisserie Chicken", "value": "rotisserie_chicken"],
        ["name": "Rumanian", "value": "rumanian"],
        ["name": "Russian", "value": "russian"],
        ["name": "Salad", "value": "salad"],
        ["name": "Sandwiches", "value": "sandwiches"],
        ["name": "Scandinavian", "value": "scandinavian"],
        ["name": "Scottish", "value": "scottish"],
        ["name": "Seafood", "value": "seafood"],
        ["name": "Serbo Croatian", "value": "serbocroatian"],
        ["name": "Signature Cuisine", "value": "signature_cuisine"],
        ["name": "Singaporean", "value": "singaporean"],
        ["name": "Slovakian", "value": "slovakian"],
        ["name": "Soul Food", "value": "soulfood"],
        ["name": "Soup", "value": "soup"],
        ["name": "Southern", "value": "southern"],
        ["name": "Spanish", "value": "spanish"],
        ["name": "Steakhouses", "value": "steak"],
        ["name": "Sushi Bars", "value": "sushi"],
        ["name": "Swabian", "value": "swabian"],
        ["name": "Swedish", "value": "swedish"],
        ["name": "Swiss Food", "value": "swissfood"],
        ["name": "Tabernas", "value": "tabernas"],
        ["name": "Taiwanese", "value": "taiwanese"],
        ["name": "Tapas Bars", "value": "tapas"],
        ["name": "Tapas/Small Plates", "value": "tapasmallplates"],
        ["name": "Tex-Mex", "value": "tex-mex"],
        ["name": "Thai", "value": "thai"],
        ["name": "Traditional Norwegian", "value": "norwegian"],
        ["name": "Traditional Swedish", "value": "traditional_swedish"],
        ["name": "Trattorie", "value": "trattorie"],
        ["name": "Turkish", "value": "turkish"],
        ["name": "Ukrainian", "value": "ukrainian"],
        ["name": "Uzbek", "value": "uzbek"],
        ["name": "Vegan", "value": "vegan"],
        ["name": "Vegetarian", "value": "vegetarian"],
        ["name": "Venison", "value": "venison"],
        ["name": "Vietnamese", "value": "vietnamese"],
        ["name": "Wok", "value": "wok"],
        ["name": "Wraps", "value": "wraps"]
    ]
}
