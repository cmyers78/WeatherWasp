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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
 
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


    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
