//
//  City.swift
//  WeatherWasp
//
//  Created by Christopher Myers on 6/23/16.
//  Copyright © 2016 Dragoman Developers, LLC. All rights reserved.
//

import UIKit

class City: NSObject {
    
    var name : String = ""
    var zipCode : String = ""
    var latitude : Double = 0.0
    var longitude : Double = 0.0
    
    override init() {
        super.init()
        
        self.name = ""
        self.zipCode = ""
        self.latitude = 0.0
        self.longitude = 0.0
        
    }
    
    
}
