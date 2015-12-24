//
//  userLocation.swift
//  TheOtherSide
//
//  Created by William Z Wang on 12/23/15.
//  Copyright © 2015 KW. All rights reserved.
//

import UIKit
import GoogleMaps

class userLocation: UIViewController
{

    @IBOutlet weak var WhereAmI: UIButton!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var OtherSide: UIButton!
    @IBOutlet weak var oppCity: UILabel!
    @IBOutlet weak var oppState: UILabel!
    @IBOutlet weak var oppCountry: UILabel!
    
    let locationManager = CLLocationManager()
    
    var lat = Double()
    
    var long = Double()
    
    @IBAction func findOppLoc(sender: UIButton) {
        
        let panoView = GMSPanoramaView(frame: CGRectZero)
//        panoView.delegate = self
        
        self.view = panoView
        panoView.moveNearCoordinate(CLLocationCoordinate2DMake(oppLat, oppLong))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        func reverseRGC() {
            var newLat = lat
            var newLong = long
            newLat = newLat * -1
            newLong = newLong + 180
            oppLat = newLat
            oppLong = newLong
            
            let location = CLLocation(latitude: newLat, longitude: newLong)
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
                
                //print(location)
                if error != nil {
                    print("Reverse geocoder failed with error" + error!.localizedDescription)
                    return
                }
                
                if placemarks!.count > 0 {
                    let pm = placemarks![0]
                    if(pm.locality == nil) {
                        
                        print("Opposite is the ocean!")
                        self.oppState.text = "Opposite is ocean"
                    }
                    else {
                        print(pm.locality)
                        self.oppState.text = pm.locality
                        
                    }
                    
                }
                else {
                    print("Problem with the data received from geocoder")
                }
            })
            print("New Latitude:", newLat)
            print("New Longitude:", newLong)
            
        }
        
        func displayLocation() {
            let newLat = lat
            let newLong = long
            oppLat = newLat
            oppLong = newLong
            
            let location = CLLocation(latitude: newLat, longitude: newLong)
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
                
                //print(location)
                if error != nil {
                    print("Reverse geocoder failed with error" + error!.localizedDescription)
                    return
                }
                
                if placemarks!.count > 0 {
                    let pm = placemarks![0]
                    if(pm.locality == nil) {
                        
                        print("Opposite is the ocean!")
                        self.oppState.text = "Opposite is ocean"
                    }
                    else {
                        print(pm.locality)
                        self.oppCity.text = pm.locality
                        self.oppState.text = pm.administrativeArea
                        self.oppCountry.text = pm.country
                    }
                    
                }
                else {
                    print("Problem with the data received from geocoder")
                }
            })
            
            print("New Latitude:", newLat)
            print("New Longitude:", newLong)
            
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
}

//extension ViewController: GMSPanoramaViewDelegate {
//    func panoramaView(view: GMSPanoramaView!, error: NSError!, onMoveNearCoordinate coordinate: CLLocationCoordinate2D) {
//        print("\(coordinate.latitude) \(coordinate.longitude) not available")
//        performSegueWithIdentifier("ErrorSegue", sender: nil)
//        
//}
//
//}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */