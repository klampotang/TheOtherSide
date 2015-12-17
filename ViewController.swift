//
//  ViewController.swift
//  TheOtherSide
//
//  Created by Kelly Lampotang on 12/16/15.
//  Copyright © 2015 KW. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController, GMSMapViewDelegate {
    
    override func loadView() {
        let panoView = GMSPanoramaView(frame: CGRectZero)
        self.view = panoView
        
        panoView.moveNearCoordinate(CLLocationCoordinate2DMake(-33.732, 150.312))
    }

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
}
