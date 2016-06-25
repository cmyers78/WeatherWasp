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
    
    

}
