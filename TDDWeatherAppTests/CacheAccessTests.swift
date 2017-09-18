//
//  CacheAccessTests.swift
//  TDDWeatherApp
//
//  Created by David Norman on 6/25/15.
//  Copyright (c) 2015 David Norman. All rights reserved.
//

import XCTest
import Nimble

class CacheAccessTests: XCTestCase {
    
    var topDict : NSDictionary!

    override func setUp() {
        super.setUp()
        let bundle = Bundle.main
        let path = bundle.path(forResource: "openWeatherApp94538Result", ofType: "txt")
        let text = try! String.init(contentsOfFile: path!, encoding: .utf8)
        print(text)
        
        let data = text.data(using: String.Encoding.utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
        
        if let tempDict = jsonObject as? NSDictionary {
            self.topDict = tempDict
            print(self.topDict)
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //MARK: cacheJsonDict(zip: String, dictionary : NSDictionary)->Bool
    
    func testCacheANewObject() {
        let result = CacheAccess.cacheJsonDict("94538", dictionary: self.topDict)
        expect(result).to(beTrue())
    }
    
    //MARK: tempFromCache(zip : String)->Double?
    
    func testRetreiveTempFromCache() {
        let temp = CacheAccess.tempFromCache("94538")
        expect(temp).to(beCloseTo(298.12, within: 0.1))
    }

    func testRetreiveNilFromCache() {
        UserDefaults.standard.set(nil, forKey: "00000")
        let temp = CacheAccess.tempFromCache("00000")
        expect(temp).to(beNil())
    }
    
    //MARK: weatherDescriptionFromCache(zip: String)->String?
    
    func testRetreiveWeatherDescriptionFromCache() {
        let temp = CacheAccess.weatherDescriptionFromCache("94538")
        expect(temp) == "01d"
    }

}
