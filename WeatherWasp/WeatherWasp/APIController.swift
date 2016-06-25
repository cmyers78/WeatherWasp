//
//  APIController.swift
//  WeatherWasp
//
//  Created by Christopher Myers on 6/25/16.
//  Copyright © 2016 Dragoman Developers, LLC. All rights reserved.
//

import UIKit

class APIController: NSObject {
    
    let session = NSURLSession.sharedSession()
    
    // weak var delegate WeatherAPIDelegate - insert here
    
    
    
    
    
    
    
    func parseJSON(data: NSData?) -> JSONDictionary? {
        
        var theDictionary : JSONDictionary? = nil
        
        if let data = data {
            do {
                
                if let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? JSONDictionary {
                    
                    theDictionary = jsonDictionary
                    //print(jsonDictionary)
                    
                    
                    
                } else {
                    print("Could not parse jsonDictionary")
                }
            } catch {
            }
        } else {
            print("Could not unwrap data")
        }
        return theDictionary
    }

    

}
