//
//  TakeMeThere2.swift
//  TheOtherSide
//
//  Created by Kelly Lampotang on 12/29/15.
//  Copyright © 2015 KW. All rights reserved.
//

import UIKit
import Foundation

class TakeMeThere2: UIViewController {
    @IBOutlet weak var CityDescription: UILabel!
    @IBOutlet weak var CityImage: UIImageView!
    @IBOutlet weak var CityTitle: UILabel!
    
    @IBAction func morepics(sender: UIButton) {
        UIApplication.sharedApplication().openURL(NSURL(string:"http://www.shutterstock.com/cat.mhtml?autocomplete_id=&language=en&lang=en&search_source=&safesearch=1&version=llv1&searchterm=" + EnterLocVariables.enterOppCity + "&media_type=images")!)
    }
    @IBAction func moreinfo(sender: UIButton) {
        UIApplication.sharedApplication().openURL(NSURL(string:"https://en.wikipedia.org/wiki/" + EnterLocVariables.enterOppCity)!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //Load the image of the description
        func load_image(urlString:String)
        {
            let imgURL: NSURL = NSURL(string: urlString)!
            let request: NSURLRequest = NSURLRequest(URL: imgURL)
            
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(request){
                (data, response, error) -> Void in
                
                if (error == nil && data != nil)
                {
                    func display_image()
                    {
                        self.CityImage.image = UIImage(data: data!)
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), display_image)
                }
                
            }
            
            task.resume()

        }
        //update the city title
        CityTitle.text = EnterLocVariables.enterOppCity
        //Load the image from the JSON
        DataManager.getCityDataforEntered { (EnteredCitySearchURL) -> Void in
            let json = JSON(data: EnteredCitySearchURL)
            //load the image from the json
            if let imageURL = json["items"][0]["pagemap"]["cse_image"][0]["src"].string
            {
                load_image(imageURL)
            }
            //load a description of the place from the json
            if let description = json["items"][0]["snippet"].string
            {
                print(description)
                self.CityDescription.text = description
            }
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}