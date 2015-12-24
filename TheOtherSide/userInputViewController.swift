//
//  userInputViewController.swift
//  TheOtherSide
//
//  Created by William Z Wang on 12/23/15.
//  Copyright © 2015 KW. All rights reserved.
//

import UIKit
import GoogleMaps

class userInputViewController: UIViewController {

    @IBOutlet weak var userLat: UITextField!

    @IBOutlet weak var userLong: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue,sender: AnyObject!) {
        let DestViewController : userLocation = segue.destinationViewController as! userLocation
       
        DestViewController.lat = Double(userLat.text!)!
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
