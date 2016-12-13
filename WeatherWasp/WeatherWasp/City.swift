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
        
        self.name = aDecoder.decodeObject(forKey: kNAME) as! String
        self.zipCode = aDecoder.decodeObject(forKey: kZIP) as! String
        self.latitude = aDecoder.decodeDouble(forKey: kLAT)
        self.longitude = aDecoder.decodeDouble(forKey: kLONG)
        
        super.init()
        
    }
    
    override init() {
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: kNAME)
        aCoder.encode(zipCode, forKey: kZIP)
        aCoder.encode(latitude, forKey: kLAT)
        aCoder.encode(longitude, forKey: kLONG)
    }
    
}
