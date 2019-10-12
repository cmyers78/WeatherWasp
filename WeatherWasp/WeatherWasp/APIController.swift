//
//  APIController.swift
//  WeatherWasp
//
//  Created by Christopher Myers on 6/25/16.
//  Copyright © 2016 Dragoman Developers, LLC. All rights reserved.
//

import UIKit

class APIController: NSObject {
    
    let session = URLSession.shared
    
    weak var delegate : WeatherAPIDelegate?
    
    func fetchWeather(_ location : String) {
        
        let urlString = "https://api.forecast.io/forecast/d47e0d371b59ef8e979861e24d10f186/\(location)"
        
        if let url = URL(string: urlString) {
            
            let task = session.dataTask(with: url, completionHandler: {
                (data, response, error) in
                
                if error != nil {
                    print(error?.localizedDescription ?? "Fucking Error")
                    return
                }
                
                if let jsonDictionary = self.parseJSON(data) {
                    print(jsonDictionary)
                
                    if let currentlyDict = jsonDictionary["currently"] as? JSONDictionary {
                        
                        print(currentlyDict)
                        
                        let theWeatherData = WeatherData(dict: currentlyDict)
                        
                        DispatchQueue.main.async(execute: {
                            self.delegate?.passWeather(theWeatherData)
                            
                            
                        })
                        
                        print(theWeatherData)
                    }
                    
                } else {
                    print("I could not parse the dictionary")
                }
            })
                task.resume()
            
        } else {
            print("Not a valid url \(urlString)")
        }
    }
    
    func parseJSON(_ data: Data?) -> JSONDictionary? {
        
        var theDictionary : JSONDictionary? = nil
        
        if let data = data {
            do {
                if let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary {
                    
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
