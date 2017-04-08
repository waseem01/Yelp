//
//  YelpService.swift
//  YelpSearch
//
//  Created by Waseem Mohd on 4/4/17.
//  Copyright © 2017 Mohammed. All rights reserved.
//

import UIKit
import Unbox
import OAuthSwift
import CoreLocation

let yelpConsumerKey = "mkRwV11HOYiZpLrs9Rht_Q"
let yelpConsumerSecret = "dJhb59MaPlPPb1TZHkBLuxtSXXk"
let yelpToken = "XqYDOzkkd0LdsYjmgllH4vRSlBzunW7T"
let yelpTokenSecret = "LsKLklj3QaaNQnDuWdQ3acPMc4Y"
let yelpBaseURL  = "http://api.yelp.com/v2/search"

typealias response = (_ result: [Business]) -> Void
typealias failure = (_ error: Error) -> Void

enum SortType: Int {
    case bestMatched = 0, distance, highestRated
}

class YelpService {

    func search(withTerm term: String, location: CLLocationCoordinate2D, deals: Bool?, distance: NSNumber?, sort: Int?, categories: [String]?, onSuccess: @escaping response, onError: @escaping failure) {

        let latitudeText: String = "\(location.latitude)"
        let longitudeText: String = "\(location.longitude)"
        let locationString = String(format: "%@,%@", latitudeText,longitudeText)
        var parameters: [String : AnyObject] = ["term": term as AnyObject, "ll": locationString  as AnyObject]

        if deals != nil {
            parameters["deals_filter"] = deals! as AnyObject?
        }

        if distance != nil {
            parameters["radius_filter"] = distance! as AnyObject?
        }

        if let sortValue = sort {
            parameters["sort"] = sortValue as AnyObject
        }

        if categories != nil {
            parameters["category_filter"] = (categories!).joined(separator: ",") as AnyObject?
        }

        let oauthswift  = OAuth1Swift(
            consumerKey: yelpConsumerKey,
            consumerSecret: yelpConsumerSecret,
            requestTokenUrl: "https://www.flickr.com/services/oauth/request_token",
            authorizeUrl:    "https://www.flickr.com/services/oauth/authorize",
            accessTokenUrl:  "https://www.flickr.com/services/oauth/access_token"
        )

        oauthswift.client.credential.oauthToken =  yelpToken
        oauthswift.client.credential.oauthTokenSecret = yelpTokenSecret

        let _ = oauthswift.client.get(yelpBaseURL, parameters: parameters,
                                      success: { response in
                                        let jsonDict = try? response.jsonObject()
                                        onSuccess(self.processResponse(response: jsonDict as! NSDictionary))
        },
                                      failure: { error in
                                        onError(error)
        })

    }

    private func processResponse(response: NSDictionary) -> [Business] {

        var businessResults = [Business]()

        if response.count > 0 {
            let data = response["businesses"] as! [NSDictionary]

            for item in data {
                do {
                    let business: Business = try unbox(dictionary: item as! UnboxableDictionary)
                    businessResults.append(business)
                } catch {
                    print("Unable to Initialize Business Data")
                }
            }
        }
        return businessResults
    }
}
