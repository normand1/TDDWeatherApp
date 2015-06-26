//
//  ViewControllerUtilityTests.swift
//  TDDWeatherApp
//
//  Created by David Norman on 6/25/15.
//  Copyright (c) 2015 David Norman. All rights reserved.
//

import UIKit
import XCTest
import Nimble

class ViewControllerUtilityTests: XCTestCase {
    
    
    //MARK: checkIfIsZip(zip : String)->Bool
    
    func testUserDoesNotEnterAZipcode() {
        expect(ViewControllerUtility.checkIfIsZip("")).to(beFalse())
    }
    
    func testUserEntersARealZipCode() {
        expect(ViewControllerUtility.checkIfIsZip("94538")).to(beTrue())
    }
    
    func testUserEntersAZipcodetThatIsTooLong() {
        expect(ViewControllerUtility.checkIfIsZip("94538234")).to(beFalse())
    }
    
    //MARK: symbolForMeasurementUnit(measurementUnit : MeasurementUnit)->String?
    
    func testCelsiusMeasurementUnitReturnsCelsiusSymbol() {
        expect(ViewControllerUtility.symbolForMeasurementUnit(MeasurementUnit.Celsius)) == "℃"
    }
    
    func testFahrenheitMeasurementUnitReturnsFahrenheitSymbol() {
        expect(ViewControllerUtility.symbolForMeasurementUnit(MeasurementUnit.Fahrenheit)) == "℉"
    }
    
    func testKelvinMeasurementUnitReturnsKelvinSymbol() {
        expect(ViewControllerUtility.symbolForMeasurementUnit(MeasurementUnit.Kelvin)) == "K"
    }
    
    //MARK: weatherDescription(apiWeatherDescription: String)->String
    
    func testMessageForWeatherDescriptionIsClear() {
        expect(ViewControllerUtility.weatherDescription("01d")) == "☀️ It's sunny outside, don't forget your suntan lotion! <tempMessage>☀️"
    }

    func testMessageForWeatherDescriptionIsRainy() {
        expect(ViewControllerUtility.weatherDescription("10d")) == "☔️ It's really coming down out there, don't forget your umbrella! <tempMessage>☔️"
    }

    func testMessageForWeatherDescriptionIsClearAtNight() {
        expect(ViewControllerUtility.weatherDescription("01n")) == "🌙 Clear skies! <tempMessage>🌙"
    }

    func testMessageForWeatherDescriptionIsRainingAtNight() {
        expect(ViewControllerUtility.weatherDescription("09n")) == "☔️ It's raining don't forget your umbrella! <tempMessage>☔️"
    }

    func testMessageForWeatherDescriptionIsMistyAtNight() {
        expect(ViewControllerUtility.weatherDescription("50n")) == "☁️ It's pretty misty out there, drive safe! <tempMessage>☁️"
    }
    
    //MARK: addInTempSpecificMessage(inout message : String ,temp : Double)
    
    func testMessageMentionsWearingAJacketForTempsLessThan5DegreesCelsius() {
        expect(ViewControllerUtility.weatherDescriptionAndTempConsiderationsCombined(277.0, apiWeatherDescription: "01d")).to(contain("wear a jacket"))
    }

    func testMessageMentionsWearingAJacketForTempsGreaterThan5DegreesCelsius() {
        expect(ViewControllerUtility.weatherDescriptionAndTempConsiderationsCombined(279.0, apiWeatherDescription: "01d")).toNot(contain("wear a jacket"))
    }

    
    
}