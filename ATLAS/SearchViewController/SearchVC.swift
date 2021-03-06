//
//  SearchVC.swift
//  ATLAS
//
//  Created by spextrum on 10/03/20.
//  Copyright © 2020 spextrum. All rights reserved.
//

import UIKit
import CoreLocation

class SearchVC: UIViewController {

    var searchView = SearchView()
    var searchLocationList: [SearchLocation] = []
    var selectedLocation:((SearchLocation) -> Void)?

    var locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        
        searchView.setup(Base: self.view)
        
        searchView.searchResultAddressLbl.isHidden = true
        searchView.searchResultLatLongLbl.isHidden = true
        
        searchView.searchTextField.addTarget(self, action: #selector(SearchVC.textFieldDidChange(_:)),
        for: .editingChanged)
        
        //TableView Register
        searchView.tableView.register(SearchListTableViewCell.self, forCellReuseIdentifier: "SearchListTableViewCell")
        
        searchView.tableView.delegate = self
        searchView.tableView.dataSource = self
        searchView.tableView.reloadData()
        
        locationManager.delegate = self
        
        getCurrentLatLng()
    }
    
// TextField Text Did Change to call this func
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.text == "" {
            searchView.tableView.isHidden = true
        } else {
            searchView.tableView.isHidden = false
            if currentLocation != nil {
                let lat = "\(currentLocation.coordinate.latitude)"
                let lng = "\(currentLocation.coordinate.longitude)"
                
                SearchHelper.shared.getLocation(inputText: textField.text ?? "", lat: lat, lng: lng, completion: { predictions in
                    self.searchLocationList = predictions.compactMap({
                        if let googlePlaceId = $0["place_id"] as? String,
                            let address = $0["description"] as? String,
                            let structuredFormat = $0["structured_formatting"] as? [String:AnyObject],
                            let title = structuredFormat["main_text"] as? String {
                            return SearchLocation(googlePlaceId, title:title, address: address)
                        }
                        return nil
                    })
                    DispatchQueue.main.async {
                        self.searchView.tableView.reloadData()
                    }
                })
            } else {
                print("Location not available")
            }
        }
    }
    
}

// Extension TableViewDelegate and TableViewDataSource
extension SearchVC : UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchLocationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchListTableViewCell") as? SearchListTableViewCell ?? SearchListTableViewCell()
        cell.placeImv.image = UIImage(named: "pin")
        cell.placenameLbl.text = searchLocationList[indexPath.row].nickName
        cell.placeaddLbl.text = searchLocationList[indexPath.row].placeId
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SearchHelper.shared.selectedLocation(placeid: searchLocationList[indexPath.row].googlePlaceId, completion: { location in
            if let lat = location["lat"] as? Double,
                let long = location["lng"] as? Double {
                self.searchView.searchResultAddressLbl.isHidden = false
                self.searchView.searchResultLatLongLbl.isHidden = false
                self.searchView.searchResultLatLongLbl.text = "Location : Lat = " + "\(lat)" + " , Long = " + "\(long)"
                self.searchView.searchResultAddressLbl.text = self.searchLocationList[indexPath.row].placeId
            }
        })
    }
    
}

// MARK - functions
extension SearchVC {
    
    func getCurrentLatLng() {
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse || CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways) {
            locationManager.requestLocation()
        }
    }
    
}

// MARK - CLLocationManager delegate functions
extension SearchVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last
        print("\(currentLocation!)")
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
        manager.stopUpdatingLocation()
    }
    
}
