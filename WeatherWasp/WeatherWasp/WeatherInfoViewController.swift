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
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var summaryLabel: UILabel!
    
    @IBOutlet weak var precipLabel: UILabel!
    
    @IBOutlet weak var humidLabel: UILabel!
    
    
    var passedCity = City()
    
    let apiController = APIController()
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.apiController.delegate = self
        
        let latlong = ("\(self.passedCity.latitude)" + "," + "\(self.passedCity.longitude)")
        
        self.apiController.fetchWeather(latlong)
        
        self.cityNameLabel.text = self.passedCity.name
       
        self.temperatureLabel.text = "00°"
        
        
        
        
    }

    func passWeather(weather : WeatherData) {
        
        print("the weather has passed")
        self.temperatureLabel.text = String(Int(weather.temperature)) + "°"
        self.precipLabel.text = String((weather.precipProbability * 100)) + "%"
        
        let humid = (weather.humidity) * 100
        self.humidLabel.text = String(humid) + "%"
        
        if weather.icon == "clear-day" {
            self.imageView.image = UIImage(named: "clear-day")
            self.summaryLabel.text = "Clear Day"
        }
        
        else if weather.icon == "clear-night" {
            self.imageView.image = UIImage(named: "clear-night")
            self.summaryLabel.text = "Clear Night"
        }
        
        else if weather.icon == "cloudy" {
            self.imageView.image = UIImage(named: "Cloudy")
            self.summaryLabel.text = "Cloudy"
        }
        
        else if weather.icon == "partly-cloudy-day" {
            self.imageView.image = UIImage(named: "partly-cloudy-day")
            self.summaryLabel.text = "Daytime. Partly Cloudy"
        }
        
        else if weather.icon == "partly-cloudy-night" {
            self.imageView.image = UIImage(named: "partly-cloudy-night")
            self.summaryLabel.text = "Nighttime. Partly Cloudy"
        }
        
        else if weather.icon == "rain" {
            self.imageView.image = UIImage(named: "rain")
            self.summaryLabel.text = "Rain"
        }
        
        else if weather.icon == "snow" {
            self.imageView.image = UIImage(named: "snow")
            self.summaryLabel.text = "Snow"
        }
        
        else if weather.icon == "wind" {
            self.imageView.image = UIImage(named: "wind")
            self.summaryLabel.text = "Windy"
        }
        
        else {
            self.imageView.image = UIImage(named: "clear-day")
            self.summaryLabel.text = "Unavailable"
        }
        
        
    }

    
}
