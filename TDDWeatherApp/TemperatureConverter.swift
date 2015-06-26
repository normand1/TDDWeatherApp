//
//  TemperatureConverter.swift
//  PigLatin
//
//  Created by David Norman on 6/24/15.
//  Copyright (c) 2015 Monsoon. All rights reserved.
//

import Foundation

class TemperatureConverter {
    
   class func convertCtoF(celsius : Double)->Double {
        let result = celsius * 1.8 + 32
        return result
    }
    
    class func convertFtoC(fahrenheit : Double)-> Double? {
        var result = ((fahrenheit - 32 ) * 5) / 9
        return result
    }
    
    class func convertKtoC(kelvin : Double)->Double {
        return kelvin - 273.15
    }
    
    class func convertCtoK(celsius : Double)->Double {
        return celsius + 273.15
    }
    
    class func convertFtoK(fahrenheit : Double)->Double {
        var result = (fahrenheit + 459.67) * (5 / 9)
        return result
    }
    
    class func convertKtoF(kelvin : Double)->Double {
        var result = (kelvin * (9/5)) - 459.67
        return result
    }
    
    class func correctTempForCurrentMeasurementUnit(kelvin: Double, measurementUnit : MeasurementUnit)->Double? {
        switch measurementUnit {
        case MeasurementUnit.Celsius:
            var cTemp = self.convertKtoC(kelvin)
            return cTemp
            
        case MeasurementUnit.Fahrenheit:
            var fTemp = self.convertKtoF(kelvin)
            return fTemp
        
        case MeasurementUnit.Kelvin:
            return kelvin
        }
        
    }
}