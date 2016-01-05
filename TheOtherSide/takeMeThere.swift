//
//  takeMeThere.swift
//  TheOtherSide
//
//  Created by Kelly Lampotang on 12/27/15.
//  Copyright © 2015 KW. All rights reserved.
//
import UIKit
import Foundation

class takeMeThere: UIViewController {
    
    @IBOutlet weak var searchImage: UIImageView!
        
    @IBOutlet weak var oppCity: UILabel!
    
    @IBAction func openLink(sender: UIButton) {
        UIApplication.sharedApplication().openURL(NSURL(string:"http://www.shutterstock.com/cat.mhtml?autocomplete_id=&language=en&lang=en&search_source=&safesearch=1&version=llv1&searchterm=" + MyVariables.oppCity + "&media_type=images")!)
    }

    @IBAction func openInfo(sender: UIButton) {
        UIApplication.sharedApplication().openURL(NSURL(string:"https://en.wikipedia.org/wiki/" + MyVariables.oppCity)!)
        
    }
    @IBOutlet weak var cityDescription: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
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
                        self.searchImage.image = UIImage(data: data!)
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), display_image)
                }
                
            }
            
            task.resume()
        }
        //Update the "City" label on the Take Me There page
        oppCity.text = MyVariables.oppCity
        //Try and get the title of the page
        DataManager.getTopAppsDataFromCSE { (SearchData) -> Void in
            let json = JSON(data: SearchData)
            /*if let title = json["items"][0]["title"].string {
                print("NSURLSession: \(title)")
            }*/
            //load the image from the json
            if let imageURL = json["items"][0]["pagemap"]["cse_image"][0]["src"].string
            {
                load_image(imageURL)
            }
            //load a description of the place from the json
            if let description = json["items"][0]["snippet"].string
            {
                print(description)
                self.cityDescription.text = description
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}