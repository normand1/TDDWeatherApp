//
//  ViewControllerUtility.swift
//  TDDWeatherApp
//
//  Created by David Norman on 6/25/15.
//  Copyright (c) 2015 David Norman. All rights reserved.
//

import Foundation

extension Double {
    func format(_ f: String) -> String {
        return NSString(format: "%\(f)f" as NSString, self) as String
    }
}

class ViewControllerUtility {
    
   class func checkIfIsZip(_ zip : String)->Bool {

    if zip.characters.count < 6 && zip.characters.count > 0  {
        return true
        }
    
    return false
    
    }
    
    class func symbolForMeasurementUnit(_ measurementUnit : MeasurementUnit)->String? {
        switch measurementUnit {
        case MeasurementUnit.celsius:
            return "℃"
        case MeasurementUnit.fahrenheit:
            return "℉"
        case MeasurementUnit.kelvin:
            return "K"
        }
    }
    
    class func weatherDescriptionAndTempConsiderationsCombined(_ temp : Double, apiWeatherDescription: String)->String {
        var combinedMessageString = weatherDescription(apiWeatherDescription)
        addInTempSpecificMessage(&combinedMessageString, temp: temp)
        return combinedMessageString
    }
    
    class func addInTempSpecificMessage(_ message : inout String ,temp : Double) {
        if temp < 278.15 {
            message = message.replacingOccurrences(of: "<tempMessage>", with: "Don't forget to wear a jacket!", options: NSString.CompareOptions.literal, range: nil)
        } else {
            message = message.replacingOccurrences(of: "<tempMessage>", with: " ", options: NSString.CompareOptions.literal, range: nil)
        }
    }
    
    
    
    class func weatherDescription(_ apiWeatherDescription: String)->String {
        switch apiWeatherDescription {
        case "01d":
            return "☀️ It's sunny outside, don't forget your suntan lotion! <tempMessage>☀️"
        case "02d":
            return "⛅️ There are a few clouds <tempMessage>⛅️"
        case "03d":
            return "☁️ Scattered clouds out right now <tempMessage>☁️"
        case "04d":
            return "☁️ A few broken clouds out there <tempMessage>☁️"
        case "09d":
            return "☔️ It's raining don't forget your umbrella! <tempMessage>☔️"
        case "10d":
            return "☔️ It's really coming down out there, don't forget your umbrella! <tempMessage>☔️"
        case "11d":
            return "☔️ It's thundering and raining don't forget your umbrella! <tempMessage>☔️"
        case "13d":
            return "❄️ It's snowing outside! <tempMessage>❄️"
        case "50d":
            return "☁️ It's pretty misty out there, drive safe! <tempMessage>☁️"
        case "01n":
            return "🌙 Clear skies! <tempMessage>🌙"
        case "02n":
            return "⛅️ There are a few clouds <tempMessage>⛅️"
        case "03n":
            return "☁️ Scattered clouds out right now <tempMessage>☁️"
        case "04n":
            return "☁️ A few broken clouds out there <tempMessage>☁️"
        case "09n":
            return "☔️ It's raining don't forget your umbrella! <tempMessage>☔️"
        case "10n":
            return "☔️ It's really coming down out there, don't forget your umbrella! <tempMessage>☔️"
        case "11n":
            return "☔️ It's thundering and raining don't forget your umbrella! <tempMessage>☔️"
        case "13n":
            return "❄️ It's snowing outside! <tempMessage>❄️"
        case "50n":
            return "☁️ It's pretty misty out there, drive safe! <tempMessage>☁️"
        default:
            return apiWeatherDescription
        }
    }

    
    
}
