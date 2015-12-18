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
        panoView.delegate = self
        self.view = panoView
        panoView.moveNearCoordinate(CLLocationCoordinate2DMake(0.000, 150.312))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*class ViewController: UIViewController {
    
    override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    }
    */
    
    
    
}

extension ViewController: GMSPanoramaViewDelegate {
    func panoramaView(view: GMSPanoramaView!, error: NSError!, onMoveNearCoordinate coordinate: CLLocationCoordinate2D) {
        print("\(coordinate.latitude) \(coordinate.longitude) not available")
        performSegueWithIdentifier("ErrorSegue", sender: nil)
        
    }
    
}
