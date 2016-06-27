//
//  WeatherInfoViewController.swift
//  WeatherWasp
//
//  Created by Christopher Myers on 6/26/16.
//  Copyright © 2016 Dragoman Developers, LLC. All rights reserved.
//

import UIKit

protocol WeatherAPIDelegate : class {
    func passWeather(weather : WeatherData)
}

class WeatherInfoViewController: UIViewController, WeatherAPIDelegate {

    @IBOutlet weak var cityNameLabel: UILabel!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var passedCity = City()
    
    let apiController = APIController()
    
    
    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.apiController.delegate = self
        
        let latlong = ("\(self.passedCity.latitude)" + "," + "\(self.passedCity.longitude)")
        
        self.apiController.fetchWeather(latlong)
        
        self.cityNameLabel.text = self.passedCity.name
       
        self.temperatureLabel.text = "0.00000"
        
        
        
        
    }

    func passWeather(weather : WeatherData) {
        
        print("the weather has passed")
         self.temperatureLabel.text = "99.9" //String(weather.temperature)
    }

    
}
