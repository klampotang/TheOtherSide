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
        
        //Try and get the title of the page
        DataManager.getTopAppsDataFromCSE { (SearchData) -> Void in
            let json = JSON(data: SearchData)
            if let title = json["items"][0]["title"].string {
                print("NSURLSession: \(title)")
            }
            if let imageURL = json["items"][0]["pagemap"]["cse_image"][0]["src"].string
            {
                print(imageURL)
                load_image(imageURL)
            }
            // More soon...
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}