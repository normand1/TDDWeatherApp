//
//  TDDWeatherAppTests.swift
//  TDDWeatherAppTests
//
//  Created by David Norman on 6/25/15.
//  Copyright (c) 2015 David Norman. All rights reserved.
//

import UIKit
import XCTest
import Nimble

class TDDWeatherAppTests: XCTestCase {
    
    var topDict : NSDictionary!
    
    override func setUp() {
        super.setUp()
        
        //let weatherDictResult = weatherAPIHandler.fetchWeatherForZip("94538")
        
        let bundle = Bundle.main
        let path = bundle.path(forResource: "openWeatherApp94538Result", ofType: "txt")
        let text = try! String.init(contentsOfFile: path!, encoding: String.Encoding.utf8)
        print(text)
        
        let data = text.data(using: String.Encoding.utf8)!
        let jsonObject: AnyObject? = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
        
        if let tempDict = jsonObject as? NSDictionary {
            self.topDict = tempDict
            print(self.topDict)

        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testOpenWeatherAPIHandlerReturnsAJSONDictObject() {
            expect(self.topDict).toNot(beNil())
    }
    
    func testWeatherAPIHandlerReturnsCurrentTemp() {
        let temp = OpenWeatherAPIHandler.temperatureFromDictionary(self.topDict)
        expect(temp).to(equal(298.12))
    }
    
    func testWeatherAPIHandlerReturnsWeatherDescription() {
        let weatherDescription = OpenWeatherAPIHandler.weatherDescriptionFromDictionary(self.topDict)
        expect(weatherDescription).to(equal("01d"))
    }
    
    func testIsValidZip() {
        let result = ViewControllerUtility.checkIfIsZip("94538")
        expect(result).to(beTrue())
    }
    func testIsInvalidZip() {
        let result = ViewControllerUtility.checkIfIsZip("")
        expect(result).to(beFalse())
    }

    
}
