//
//  CityTableViewController.swift
//  WeatherWasp
//
//  Created by Christopher Myers on 6/23/16.
//  Copyright © 2016 Dragoman Developers, LLC. All rights reserved.
//

import UIKit
import CoreLocation

class CityTableViewController: UITableViewController {
    
    let kCITY = "kCITY"
    
    var cityName : String = ""
    var zipcode : String = ""
    
    var citiesArray = [City]()
    var theCity = City()
    var locationManager = CLLocationManager()
    var currentLocation: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadCityArray()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationPermissions()
    }
    
    func locationPermissions() {
        locationManager.delegate = self
        let status = CLAuthorizationStatus.authorizedWhenInUse
        if status != .denied {
            locationManager.startUpdatingLocation()
            locationManager.requestLocation()
       //     locationManager.stopUpdatingLocation()
            
        }
        
    }
    
    func findAndSetCurrent(from location: CLLocation) {
        
        print(location.coordinate.latitude)
        print(location.coordinate.longitude)
        CLGeocoder().reverseGeocodeLocation(location) { (placemark, error) in
            if error != nil {
                print("didn't work")
            } else {
                print(placemark)
                let foundLocation = placemark?.first
                print("\(foundLocation?.locality), \(foundLocation?.administrativeArea)")
                if let city = foundLocation?.locality, let state = foundLocation?.administrativeArea {
                    self.currentLocation = "\(city), \(state)"
                }
                let currentCity = City()
                currentCity.latitude = location.coordinate.latitude
                currentCity.longitude = location.coordinate.longitude
                currentCity.name = "Current Location"
                currentCity.zipCode = self.currentLocation ?? ""
                self.citiesArray.insert(currentCity, at: 0)
                self.tableView.reloadData()
            }
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.citiesArray.count
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            self.citiesArray.remove(at: indexPath.row)
            self.tableView.reloadData()
            self.saveCityArray()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CityTableViewCell

        self.theCity = self.citiesArray[indexPath.row]
        
        cell.cityNameLabel.text = self.theCity.name
        cell.zipcodeLabel.text = self.theCity.zipCode
        

        return cell
    }
    // MARK: Navigation
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.theCity = self.citiesArray[indexPath.row]
        
        performSegue(withIdentifier: "WeatherSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WeatherSegue" {
            
            if let controller = segue.destination as? WeatherInfoViewController {
                controller.passedCity = self.theCity
            }
        }
    }
    // MARK: Add a City
    @IBAction func addCityPressed(_ sender: AnyObject) {
        
        let alertController = UIAlertController(title: "Add City", message: "", preferredStyle: UIAlertController.Style.alert)
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: {  alert -> Void in
            
            let cityTextField = alertController.textFields![0] as UITextField
            let zipcodeTextField = alertController.textFields![1] as UITextField
            
            if let name = cityTextField.text {
                self.cityName = name
            }
            
            if let zip = zipcodeTextField.text {
                self.zipcode = zip
            }
            
            // call geocode
            self.geocoding(self.zipcode, completion: { (latitude, longitude) in
                
                let currentCity = City()
                
                    currentCity.latitude = latitude
                    currentCity.longitude = longitude
                    currentCity.name = self.cityName
                    currentCity.zipCode = self.zipcode
                
                self.citiesArray.append(currentCity)
                self.saveCityArray()
                
                DispatchQueue.main.async(execute: {
                    
                    // could also move the append city to here as well
                    
                    self.tableView.reloadData()
                    print(currentCity.latitude, currentCity.longitude, currentCity.zipCode)
                    
                })
            })
            print(self.citiesArray.count)
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
            (action : UIAlertAction!) -> Void in
        })
        
        alertController.addTextField {(textField : UITextField!) -> Void in
            textField.placeholder = "Enter City Name"
        }
        
        alertController.addTextField {(textField : UITextField!) -> Void in textField.placeholder = "Enter Zip Code"
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion:  nil)
        
    }
    // MARK: Geocoding app
    func geocoding(_ location: String, completion: @escaping (Double, Double) -> ()) {
        CLGeocoder().geocodeAddressString(location) {
            
            (placemarks, error) in
            guard let placemark = placemarks, let location = placemark.first?.location else { return }
            if placemark.count > 0 {
                let coordinate = location.coordinate
                completion((coordinate.latitude), (coordinate.longitude))
            }
        }
    }

    func saveCityArray() {
        
        let savedCity = NSKeyedArchiver.archivedData(withRootObject: self.citiesArray)
            
        UserDefaults.standard.set(savedCity, forKey: kCITY)
        
        
        UserDefaults.standard.synchronize()
        
    }
    
    func loadCityArray() {
        
        if let data = UserDefaults.standard.object(forKey: kCITY) as? Data {
            
            if let arrayOfCities = NSKeyedUnarchiver.unarchiveObject(with: data) as? [City] {
                
                self.citiesArray.append(contentsOf: arrayOfCities)
                self.tableView.reloadData()
            }
            
        } else {
            print ("no items saved")
        }
    }

}

extension CityTableViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationPermissions()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !citiesArray.isEmpty {
            let current = CLLocation().coordinate
            print("locations: \(locations.last)")
            guard let location = locations.first else { return }
            findAndSetCurrent(from: location)
            manager.stopUpdatingLocation()
        }
        manager.stopUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
