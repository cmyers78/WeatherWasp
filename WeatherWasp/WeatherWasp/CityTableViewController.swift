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
    
    var cityName : String = ""
    var zipcode : String = ""
    
    var citiesArray = [City]()
    var theCity = City()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.citiesArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CityTableViewCell

        self.theCity = self.citiesArray[indexPath.row]
        
        cell.cityNameLabel.text = self.theCity.name
        cell.zipcodeLabel.text = self.theCity.zipCode
        

        return cell
    }
    // MARK: Navigation
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.theCity = self.citiesArray[indexPath.row]
        
        performSegueWithIdentifier("WeatherSegue", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "WeatherSegue" {
            
            if let controller = segue.destinationViewController as? WeatherInfoViewController {
                controller.passedCity = self.theCity
            }
        }
    }
    // MARK: Add a City
    @IBAction func addCityPressed(sender: AnyObject) {
        
        let alertController = UIAlertController(title: "Add City", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.Default, handler: {  alert -> Void in
            
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
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    // could also move the append city to here as well
                    
                    self.tableView.reloadData()
                    print(currentCity.latitude, currentCity.longitude, currentCity.zipCode)
                    
                })
            })
            print(self.citiesArray.count)
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: {
            (action : UIAlertAction!) -> Void in
        })
        
        alertController.addTextFieldWithConfigurationHandler {(textField : UITextField!) -> Void in
            textField.placeholder = "Enter City Name"
        }
        
        alertController.addTextFieldWithConfigurationHandler {(textField : UITextField!) -> Void in textField.placeholder = "Enter Zip Code"
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion:  nil)
        
    }
    // MARK: Geocoding app
    func geocoding(location: String, completion: (Double, Double) -> ()) {
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



}
