//
//  SearchHelper.swift
//  ATLAS
//
//  Created by spextrum on 10/03/20.
//  Copyright © 2020 spextrum. All rights reserved.
//

import UIKit
import Alamofire

struct SearchLocation:Equatable {
    static func == (lhs: SearchLocation, rhs: SearchLocation) -> Bool {
        return lhs.nickName == rhs.nickName && lhs.placeId == rhs.placeId && lhs.googlePlaceId == rhs.googlePlaceId
    }
    var nickName: String!
    var placeId: String!
    var googlePlaceId: String!
    
    init(_ googlePlaceId: String,title: String,address: String) {
        self.googlePlaceId = googlePlaceId
        self.nickName = title
        self.placeId = address
    }
}

class SearchHelper {
    
    static let shared = SearchHelper()
    static let appFontName = "Laksaman"

    func getLocation(inputText : String, lat: String, lng: String, completion:@escaping ([[String: Any]])->()) {
//        let url = "http://13.56.246.254:3001/places/" + inputText
        let url = "http://54.215.230.210:3001/places/\(inputText)?lat=\(lat)&lng=\(lng)"
        print(url)
        if ConnectionCheck.isConnectedToNetwork() {
            Alamofire.request(url, method: .get, parameters: [:], headers: ["Accept": "application/json"])
                .responseJSON { response in
                    print(response.result.value as Any)
                    if let response = response.result.value as? [String:AnyObject] {
                        if let placeJson = response["place_json"] as? [String: AnyObject] {
                            if let status = placeJson["status"] as? String, status == "OK" {
                                if let predictions = placeJson["predictions"] as? [[String:AnyObject]] {
                                    completion(predictions)
                                }
                            }
                        }
                    }
            }
        } else {
            print("Please check internet connection")
        }
    }
    
    func selectedLocation(placeid : String, completion:@escaping ([String: Any])->()) {
        if ConnectionCheck.isConnectedToNetwork() {
            let url = "http://13.56.246.254:3001/places/location/" + placeid
            print(url)
            Alamofire.request(url, method: .get, parameters: [:], headers: ["Accept": "application/json"])
                .responseJSON { response in
                    print(response.result.value as Any)
                    if let response = response.result.value as? [String:AnyObject] {
                        if let locaionDetails = response["locaion_details"] as? [String: AnyObject] {
                            if let status = locaionDetails["status"] as? String, status == "OK" {
                                if let result = locaionDetails["result"] as? [String:AnyObject] {
                                    if let geometry = result["geometry"] as? [String:AnyObject] {
                                        if let location = geometry["location"] as? [String: AnyObject] {
                                            completion(location)
                                        }
                                    }
                                }
                            }
                        }
                    }
            }
        } else {
            print("Please check internet connection")
        }
    }
    
}
