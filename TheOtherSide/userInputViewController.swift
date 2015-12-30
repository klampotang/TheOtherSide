//
//  userInputViewController.swift
//  TheOtherSide
//
//  Created by William Z Wang on 12/23/15.
//  Copyright © 2015 KW. All rights reserved.
//

import UIKit
import GoogleMaps

class userInputViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userLat: UITextField!

    @IBOutlet weak var userLong: UITextField!
    
    @IBOutlet weak var done: UIButton!
    
    @IBOutlet weak var back: UIButton!
    
    @IBAction func back(sender: UIButton) {
         navigationController?.popViewControllerAnimated(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue,sender: AnyObject!) {
        if segue.identifier == "user" {
            let DestViewController : userLocation = (segue.destinationViewController as? userLocation)!
                DestViewController.lat = Double(userLat.text!)!
                DestViewController.long = Double(userLong.text!)!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.userLat.delegate = self;
        self.userLong.delegate = self;
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

}
