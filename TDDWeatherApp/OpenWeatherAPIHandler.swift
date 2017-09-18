//
//  OpenWeatherAPIHandler.swift
//  TDDWeatherApp
//
//  Created by David Norman on 6/25/15.
//  Copyright (c) 2015 David Norman. All rights reserved.
//

import Foundation


class OpenWeatherAPIHandler {
    
    class func fetchWeatherForZip(_ zip : String!, callback : @escaping (_ tempResult : Double?, _ weatherDescription: String) -> Void) {
        
        let controller = RequestController()
        
        controller.sendRequest(zip, callback: { (success, statusCode, errorDescription, data) -> Void in

            do {
                
                guard let data = data else { return }
            
            let jsonObj = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.init(rawValue: 0))
                
                if let topDictionary = jsonObj as? NSDictionary {
                    //cache the top Dictionary for later use!
                    CacheAccess.cacheJsonDict(zip, dictionary: topDictionary)
                    if let temp = self.temperatureFromDictionary(topDictionary) {
                        if let weatherDescription = self.weatherDescriptionFromDictionary(topDictionary) {
                            callback(temp, weatherDescription)
                        }
                    } else {
                        if topDictionary["message"] != nil {
                            callback(nil, topDictionary["message"] as! String)
                        }
                    }
                }
        
            } catch let error {
                print(error)
            }

            
        })
    }
    
    class func temperatureFromDictionary(_ dictionary : NSDictionary)->Double? {
        if let mainDict : NSDictionary = dictionary["main"] as? NSDictionary {
            let currentTemp = mainDict["temp"] as! Double
            print("current temp: \(currentTemp)")
            return currentTemp
        }
        
        return nil
    }
    
    class func weatherDescriptionFromDictionary(_ dictionary : NSDictionary)->String? {
        if let weatherArray : NSArray = dictionary["weather"] as? NSArray {
            if let weatherDict = weatherArray[0] as? NSDictionary {
                if let main: String = weatherDict["icon"] as? String {
                    return main
                }
            }
        }
        
        return "..."
    }
    
}
