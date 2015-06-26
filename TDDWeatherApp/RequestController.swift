//
//  RequestController.swift
//  TDDWeatherApp
//
//  Created by David Norman on 6/25/15.
//  Copyright (c) 2015 David Norman. All rights reserved.
//

import Foundation

class RequestController  {
    
    func sendRequest(zipCode : String, callback : (success : Bool, statusCode : Int, errorDescription : String, data : NSData?)->Void) {
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        let session = NSURLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        var URL = NSURL(string: "http://api.openweathermap.org/data/2.5/weather")
        let URLParams = [
            "zip": "\(zipCode),us",
        ]
        URL = self.NSURLByAppendingQueryParameters(URL, queryParameters: URLParams)
        println("url being called: \(URL!)")
        let request = NSMutableURLRequest(URL: URL!)
        request.HTTPMethod = "GET"
        
        /* Start a new Task */
        let task = session.dataTaskWithRequest(request, completionHandler: { (data : NSData!, response : NSURLResponse!, error : NSError!) -> Void in
            if (error == nil) {
                // Success
                let statusCode = (response as! NSHTTPURLResponse).statusCode
                println("URL Session Task Succeeded: HTTP \(statusCode)")
                callback(success: true, statusCode: statusCode, errorDescription: "", data: data)
            }
            else {
                // Failure
                println("URL Session Task Failed: %@", error.localizedDescription);
                callback(success: false, statusCode: 0, errorDescription: error.localizedDescription, data: nil)
            }
        })
        task.resume()
    }
    
    func stringFromQueryParameters(queryParameters : Dictionary<String, String>) -> String {
        var parts: [String] = []
        for (name, value) in queryParameters {
            var part = NSString(format: "%@=%@",
                name.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!,
                value.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)
            parts.append(part as String)
        }
        return "&".join(parts)
    }
    
    func NSURLByAppendingQueryParameters(URL : NSURL!, queryParameters : Dictionary<String, String>) -> NSURL {
        let URLString : NSString = NSString(format: "%@?%@", URL.absoluteString!, self.stringFromQueryParameters(queryParameters))
        return NSURL(string: URLString as String)!
    }
}

