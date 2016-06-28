//
//  WeatherData.swift
//  WeatherWasp
//
//  Created by Christopher Myers on 6/25/16.
//  Copyright © 2016 Dragoman Developers, LLC. All rights reserved.
//

import UIKit

class WeatherData: NSObject {
    
    var summaryDescription : String = ""
    var icon : String = ""
    var precipProbability : Double = 0.0
    var temperature : Double = 0.0
    var humidity : Double = 0.0
    var windSpeed : Double = 0.0
    
    override init() {
        super.init()
        
        self.summaryDescription = ""
        self.icon = ""
        self.precipProbability = 0.0
        self.temperature = 0.0
        self.humidity = 0.0
        self.windSpeed = 0.0
    }
    
    init(dict: JSONDictionary) {
        super.init()
        
        if let summary = dict["summary"] as? String {
            self.summaryDescription = summary
        
        } else {
            print("I could not parse summary")
        }
        
        if let icon = dict["icon"] as? String {
            self.icon = icon
            
        } else {
            print("I could not parse the icon")
        }
        
        if let precipitation = dict["precipProbability"] as? Double {
            self.precipProbability = precipitation
            
        } else {
            print("I could not parse precipitation")
        }
        
        if let temp = dict["temperature"] as? Double {
            self.temperature = temp
            
        } else {
            print("I could not parse the temperature")
        }
        
        if let humid = dict["humidity"] as? Double {
            self.humidity = humid
            
        } else {
            print("I could not parse humidity")
        }
        
        if let wind = dict["windSpeed"] as? Double {
            self.windSpeed = wind
            
        } else {
            print("I could not parse speed")
        }
        
    }

}
