//
//  RequestController.swift
//  TDDWeatherApp
//
//  Created by David Norman on 6/25/15.
//  Copyright (c) 2015 David Norman. All rights reserved.
//

import Foundation

class RequestController  {
    
    func sendRequest(_ zipCode : String, callback : @escaping (_ success : Bool, _ statusCode : Int, _ errorDescription : String, _ data : Data?)->Void) {
        let sessionConfig = URLSessionConfiguration.default
        
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        var URL = Foundation.URL(string: "http://api.openweathermap.org/data/2.5/weather")
        let URLParams = [
            "zip": "\(zipCode),us",
            "APPID": "5c2f9d0cce66558829a9ac6aad9ec2df"
        ]
        URL = self.NSURLByAppendingQueryParameters(URL, queryParameters: URLParams)
        print("url being called: \(URL!)")
        let request = NSMutableURLRequest(url: URL!)
        request.httpMethod = "GET"
        
        /* Start a new Task */
        
        guard let requestURL = request.url else { return }
        
        let task = session.dataTask(with: requestURL) { (data, response, error) in
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
                callback(true, statusCode, "", data)
            } else {
                // Failure
                print("URL Session Task Failed: %@", error?.localizedDescription ?? "no error message");
                callback(false, 0, error!.localizedDescription, data)
            }
        }
        
        task.resume()
    }
    
    func stringFromQueryParameters(_ queryParameters : Dictionary<String, String>) -> String {
        var parts: [String] = []
        for (name, value) in queryParameters {
            var part = NSString(format: "%@=%@",
                name.addingPercentEscapes(using: String.Encoding.utf8)!,
                value.addingPercentEscapes(using: String.Encoding.utf8)!)
            parts.append(part as String)
        }
        return parts.joined(separator: "&")
    }
    
    func NSURLByAppendingQueryParameters(_ URL : Foundation.URL!, queryParameters : Dictionary<String, String>) -> Foundation.URL {
        let URLString : NSString = NSString(format: "%@?%@", URL.absoluteString, self.stringFromQueryParameters(queryParameters))
        return Foundation.URL(string: URLString as String)!
    }
}

