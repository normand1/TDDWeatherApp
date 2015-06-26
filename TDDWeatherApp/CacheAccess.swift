//
//  CacheAccess.swift
//  TDDWeatherApp
//
//  Created by David Norman on 6/25/15.
//  Copyright (c) 2015 David Norman. All rights reserved.
//

import Foundation

 let weatherAppKey = "com.monsoonco.weatherapp"

class CacheAccess {
    
    class func cacheJsonDict(zip: String, dictionary : NSDictionary)->Bool {
        NSUserDefaults.standardUserDefaults().setObject(dictionary, forKey: zip)
        let result = NSUserDefaults.standardUserDefaults().objectForKey(zip) as? NSDictionary
        if result != nil {
            return true
        } else {
            return false
        }
    }

    class func tempFromCache(zip : String)->Double? {
        if let resultDictionary = NSUserDefaults.standardUserDefaults().objectForKey(zip) as? NSDictionary {
            if let temp = OpenWeatherAPIHandler.temperatureFromDictionary(resultDictionary) {
                return temp
            }
        }
        return nil
    }
    
    class func weatherDescriptionFromCache(zip: String)->String? {
        if let resultDictionary = NSUserDefaults.standardUserDefaults().objectForKey(zip) as? NSDictionary {
            if let temp = OpenWeatherAPIHandler.weatherDescriptionFromDictionary(resultDictionary) {
                return temp
            }
        }
        return nil
    }
    
    class func zipIsCached(zip : String)->Bool {
        let temp = CacheAccess.tempFromCache(zip)
        if temp != nil {
            return true
        } else {
            return false
        }
    }

}