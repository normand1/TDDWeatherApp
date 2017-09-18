//
//  TemperatureConverterTests.swift
//  PigLatin
//
//  Created by David Norman on 6/24/15.
//  Copyright (c) 2015 Monsoon. All rights reserved.
//


import UIKit
import XCTest
import Nimble

class TemperatureConverterTests: XCTestCase {

    func testConvertCtoF() {
        expect(TemperatureConverter.convertCtoF(10.0)).to(beCloseTo(50.0, within: 0.1))
    }
    
    func testConvertFtoC() {
        expect(TemperatureConverter.convertFtoC(10.0)).to(beCloseTo(-12.2, within: 0.1))
    }
    
    func testConvertKtoC() {
      expect(TemperatureConverter.convertKtoC(10.0)).to(beCloseTo(-263.15, within: 0.1))
    }
    
    func testConvertCtoK() {
      expect(TemperatureConverter.convertCtoK(10.0)).to(beCloseTo(283.15, within: 0.1))
    }
    
    func testConvertFtoK() {
        expect(TemperatureConverter.convertFtoK(10)).to(beCloseTo(260.9, within: 0.1))
    }
    
    func testConvertKtoF() {
        expect(TemperatureConverter.convertKtoF(10)).to(beCloseTo(-441.6, within: 0.1))
    }
    
    func testKelvinTempReturned() {
        expect(TemperatureConverter.correctTempForCurrentMeasurementUnit(10.0, measurementUnit: MeasurementUnit.kelvin)).to(beCloseTo(10.0, within: 0.1))
    }
    
    func testCelsiusTempReturned() {
        expect(TemperatureConverter.correctTempForCurrentMeasurementUnit(10.0, measurementUnit: MeasurementUnit.celsius)).to(beCloseTo(-263.15, within: 0.1))
    }
    
    func testFahrenheitTempReturned() {
        expect(TemperatureConverter.correctTempForCurrentMeasurementUnit(10.0, measurementUnit: MeasurementUnit.fahrenheit)).to(beCloseTo(-441.6, within: 0.1))
    }
}
