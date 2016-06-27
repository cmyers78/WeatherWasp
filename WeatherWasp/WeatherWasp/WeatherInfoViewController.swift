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
    
    var currentWeather = WeatherData()
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.apiController.delegate = self
        
        let latlong = ("\(self.passedCity.latitude)" + "," + "\(self.passedCity.longitude)")
        
        self.apiController.fetchWeather(latlong)
        
        self.cityNameLabel.text = self.passedCity.name
        self.temperatureLabel.text = String(self.currentWeather.temperature)
        
        
        
        
        
        

        
        
        
    }

    func passWeather(weather : WeatherData) {
        
    }

}
