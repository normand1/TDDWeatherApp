//
//  TemperatureConverter.swift
//  PigLatin
//
//  Created by David Norman on 6/24/15.
//  Copyright (c) 2015 Monsoon. All rights reserved.
//

import Foundation

class TemperatureConverter {
    
   class func convertCtoF(_ celsius : Double)->Double {
        let result = celsius * 1.8 + 32
        return result
    }
    
    class func convertFtoC(_ fahrenheit : Double)-> Double? {
        let result = ((fahrenheit - 32 ) * 5) / 9
        return result
    }
    
    class func convertKtoC(_ kelvin : Double)->Double {
        return kelvin - 273.15
    }
    
    class func convertCtoK(_ celsius : Double)->Double {
        return celsius + 273.15
    }
    
    class func convertFtoK(_ fahrenheit : Double)->Double {
        let result = (fahrenheit + 459.67) * (5 / 9)
        return result
    }
    
    class func convertKtoF(_ kelvin : Double)->Double {
        let result = (kelvin * (9/5)) - 459.67
        return result
    }
    
    class func correctTempForCurrentMeasurementUnit(_ kelvin: Double, measurementUnit : MeasurementUnit)->Double? {
        switch measurementUnit {
        case MeasurementUnit.celsius:
            var cTemp = self.convertKtoC(kelvin)
            return cTemp
            
        case MeasurementUnit.fahrenheit:
            var fTemp = self.convertKtoF(kelvin)
            return fTemp
        
        case MeasurementUnit.kelvin:
            return kelvin
        }
        
    }
}
