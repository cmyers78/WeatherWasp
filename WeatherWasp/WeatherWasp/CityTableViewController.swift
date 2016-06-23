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
            
            
            
        })
        
        
        
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
