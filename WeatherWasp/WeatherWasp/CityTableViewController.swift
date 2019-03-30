//
//  CityTableViewController.swift
//  WeatherWasp
//
//  Created by Christopher Myers on 6/23/16.
//  Copyright © 2016 Dragoman Developers, LLC. All rights reserved.
//

import UIKit
import CoreLocation
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}



class CityTableViewController: UITableViewController {
    
    let kCITY = "kCITY"
    
    var cityName : String = ""
    var zipcode : String = ""
    
    var citiesArray = [City]()
    var theCity = City()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadCityArray()
        
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
            
            if placemarks?.count > 0 {
                let placemark = placemarks?[0]
                let location = placemark!.location
                let coordinate = location?.coordinate
                completion((coordinate?.latitude)!, (coordinate?.longitude)!)
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
                
                self.citiesArray = arrayOfCities
                self.tableView.reloadData()
            }
            
        } else {
            print ("no items saved")
        }
    }

}
