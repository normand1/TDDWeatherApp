//
//  OpenWeatherAPIHandler.swift
//  TDDWeatherApp
//
//  Created by David Norman on 6/25/15.
//  Copyright (c) 2015 David Norman. All rights reserved.
//

import Foundation


class OpenWeatherAPIHandler {
    
    class func fetchWeatherForZip(zip : String!, callback : (tempResult : Double?, weatherDescription: String) -> Void) {
        
        var controller = RequestController()
        controller.sendRequest(zip, callback: { (success, statusCode, errorDescription, data) -> Void in
            var error: NSError?
            let jsonObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: &error)

            if let topDictionary = jsonObject as? NSDictionary {
                //cache the top Dictionary for later use!
                CacheAccess.cacheJsonDict(zip, dictionary: topDictionary)
                if let temp = self.temperatureFromDictionary(topDictionary) {
                    if let weatherDescription = self.weatherDescriptionFromDictionary(topDictionary) {
                        callback(tempResult: temp, weatherDescription: weatherDescription)
                    }
                } else {
                    if topDictionary["message"] != nil {
                        callback(tempResult: nil, weatherDescription: topDictionary["message"] as! String)
                    }
                }
            }
        })
    }
    
    class func temperatureFromDictionary(dictionary : NSDictionary)->Double? {
        if let mainDict : NSDictionary = dictionary["main"] as? NSDictionary {
            let currentTemp = mainDict["temp"] as! Double
            print("current temp: \(currentTemp)")
            return currentTemp
        }
        
        return nil
    }
    
    class func weatherDescriptionFromDictionary(dictionary : NSDictionary)->String? {
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