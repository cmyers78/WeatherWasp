//
//  City.swift
//  WeatherWasp
//
//  Created by Christopher Myers on 6/23/16.
//  Copyright © 2016 Dragoman Developers, LLC. All rights reserved.
//

import UIKit

class City: NSObject, NSCoding {
    
    let kNAME = "kNAME"
    let kZIP = "kZIP"
    let kLAT = "kLAT"
    let kLONG = "kLONG"
    
    
    var name : String = ""
    var zipCode : String = ""
    var latitude : Double = 0.0
    var longitude : Double = 0.0
    
    required init?(coder aDecoder : NSCoder) {
        
        self.name = aDecoder.decodeObjectForKey(kNAME) as! String
        self.zipCode = aDecoder.decodeObjectForKey(kZIP) as! String
        self.latitude = aDecoder.decodeDoubleForKey(kLAT)
        self.longitude = aDecoder.decodeDoubleForKey(kLONG)
        
        super.init()
        
    }
    
    override init() {
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: kNAME)
        aCoder.encodeObject(zipCode, forKey: kZIP)
        aCoder.encodeDouble(latitude, forKey: kLAT)
        aCoder.encodeDouble(longitude, forKey: kLONG)
    }
    
}
