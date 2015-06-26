//
//  ViewController.swift
//  TDDWeatherApp
//
//  Created by David Norman on 6/25/15.
//  Copyright (c) 2015 David Norman. All rights reserved.
//

import UIKit

enum MeasurementUnit : Int {
    case Celsius
    case Fahrenheit
    case Kelvin
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var suggestionLabel: UILabel!
    
    
    var currentMeasurementUnit : MeasurementUnit
    var fifteenMinTimer : NSTimer
    var shouldUpdate : Bool
    
    required init(coder aDecoder: NSCoder) {
        currentMeasurementUnit = MeasurementUnit.Fahrenheit
        fifteenMinTimer = NSTimer()
        shouldUpdate = true
        super.init(coder: aDecoder)
    }
    
    //MARK: View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fifteenMinsInSecs = (60 * 15) as NSTimeInterval
        self.fifteenMinTimer = NSTimer(timeInterval: fifteenMinsInSecs, target: self, selector: Selector("setShouldUpdateToTrue"), userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(self.fifteenMinTimer, forMode: NSRunLoopCommonModes)
        self.customizeUI()
    }
    
    func customizeUI() {
        self.zipTextField.backgroundColor = UIColor.clearColor()
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(2, animations: { () -> Void in
            self.view.backgroundColor = UIColor(red: 0.863, green: 0.925, blue: 0.992, alpha: 1.00)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setShouldUpdateToTrue() {
        shouldUpdate = true
    }
    
    
    func updateWeatherFromNetwork() {
        shouldUpdate = false
        OpenWeatherAPIHandler.fetchWeatherForZip(self.zipTextField.text, callback: {
            (tempResult, weatherDescription) -> Void in
            //set UI Temp element with tempResult
            self.updateUIWithLatestTemp(tempResult, weatherDescription: weatherDescription)
        })
    }
    
    func updateWeatherFromCache() {
        if let tempResult = CacheAccess.tempFromCache(self.zipTextField.text) {
            if let weatherDescription = CacheAccess.weatherDescriptionFromCache(self.zipTextField.text) {
                self.updateUIWithLatestTemp(tempResult, weatherDescription: weatherDescription)
            }
        } else {
            self.updateWeatherFromNetwork()
        }
        // Data for zip code had not yet been fetched so update from the network instead
        
    }
    
    func updateUIWithLatestTemp(tempResult : Double?, weatherDescription : String) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            if let tempResultExists = tempResult {
                if let updatedTempResult = TemperatureConverter.correctTempForCurrentMeasurementUnit(tempResultExists, measurementUnit: self.currentMeasurementUnit) {
                    let tempUnitSymbol = ViewControllerUtility.symbolForMeasurementUnit(self.currentMeasurementUnit)
                    let tempResultString = updatedTempResult.format(".01")
                    self.tempLabel.text = "\(tempResultString)\(tempUnitSymbol!)"
                    self.suggestionLabel.text = "\(ViewControllerUtility.weatherDescriptionAndTempConsiderationsCombined(tempResultExists, apiWeatherDescription: weatherDescription))"
                    self.updateBackgroundColorForTemp(tempResultExists)
                } else {
                    self.showErrorAlert()
                }
            } else {
                self.showErrorAlert()
            }
        })
    }
    
    func updateBackgroundColorForTemp(tempInKelvin : Double) {
        UIView.animateWithDuration(2, animations: { ()  -> Void in
            
            switch tempInKelvin {
            case 0...288:
                self.view.backgroundColor = UIColor(red: 0.667, green: 0.831, blue: 0.976, alpha: 1.00)
            case 289...297:
                self.view.backgroundColor = UIColor(red: 0.671, green: 0.980, blue: 0.886, alpha: 1.00)
            case 298...302:
                self.view.backgroundColor = UIColor(red: 0.973, green: 0.824, blue: 0.663, alpha: 1.00)
            case 303...500:
                self.view.backgroundColor = UIColor(red: 1.000, green: 0.588, blue: 0.408, alpha: 1.00)
            default:
                self.view.backgroundColor = UIColor(red: 0.863, green: 0.925, blue: 0.992, alpha: 1.00)
            }
        })
    }
    
    //MARK: Actions
    
    @IBAction func FindWeatherTap(sender: UIButton) {
        
        if ViewControllerUtility.checkIfIsZip(self.zipTextField.text) {
            if CacheAccess.zipIsCached(self.zipTextField.text) {
                self.handleZipIsAlreadyCached()
            } else {
                self.updateWeatherFromNetwork()
            }
            self.view.endEditing(true)
        } else {
            self.showErrorAlert()
        }
    }
    
    func handleZipIsAlreadyCached() {
        if self.shouldUpdate {
            self.shouldUpdate = false
            self.updateWeatherFromNetwork()
        } else {
            self.updateWeatherFromCache()
        }
    }
    
    func showErrorAlert() {
        let alert = UIAlertView(title: "Error", message: "Please enter a correct zipcode", delegate: self, cancelButtonTitle: "OK")
        alert.show()
        
    }
    
    @IBAction func tapChangeMeasurementUnit(sender: UIButton) {
        
        //cycle to next measurement unit [C, F, K] enum
        let nextMeasurementUnit = (self.currentMeasurementUnit.rawValue + 1) % 3
        self.currentMeasurementUnit = MeasurementUnit(rawValue: nextMeasurementUnit)!
        self.FindWeatherTap(sender)
    }
    
}

