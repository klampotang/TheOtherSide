//
//  DataManager.swift
//  TheOtherSide
//
//  Created by Kelly Lampotang on 12/26/15.
//  Copyright © 2015 KW. All rights reserved.
//

import Foundation

//let GoogleSearchURL = "https://www.googleapis.com/customsearch/v1?q=tokyo&key=AIzaSyArw5o2-7FeUrTPhDHoNvEhLc1pb3G26cs&cx=005988043632614451431:jhb645ctk_c"

let CitySearchURL = "https://www.googleapis.com/customsearch/v1?q=" + MyVariables.oppCity + "&key=AIzaSyArw5o2-7FeUrTPhDHoNvEhLc1pb3G26cs&cx=005988043632614451431:jhb645ctk_c"

let EnteredCitySearchURL = "https://www.googleapis.com/customsearch/v1?q=" + EnterLocVariables.enterOppCity + "&key=AIzaSyArw5o2-7FeUrTPhDHoNvEhLc1pb3G26cs&cx=005988043632614451431:jhb645ctk_c"

class DataManager {
    class func loadDataFromURL(url: NSURL, completion:(data: NSData?, error: NSError?) -> Void) {
        let session = NSURLSession.sharedSession()
        
        // Use NSURLSession to get data from an NSURL
        let loadDataTask = session.dataTaskWithURL(url, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if let responseError = error {
                completion(data: nil, error: responseError)
            } else if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    let statusError = NSError(domain:"com.raywenderlich", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    completion(data: nil, error: statusError)
                } else {
                    completion(data: data, error: nil)
                }
            }
        })
        
        loadDataTask.resume()
    }
    
    class func getTopAppsDataFromCSE(success: ((SearchData: NSData!) -> Void)) {
        //1
        loadDataFromURL(NSURL(string: CitySearchURL)!, completion:{(data, error) -> Void in
            //2
            if let urlData = data {
                //3
                success(SearchData: urlData)
            }
        })
    }
    
    class func getCityDataforEntered(success:((EnteredLocData:NSData!)->Void)){
        //1
        loadDataFromURL(NSURL(string: EnteredCitySearchURL)!, completion:{(data, error) -> Void in
            //2
            if let urlData = data {
                //3
                success(EnteredLocData: urlData)
            }
        })
    }



}