//
//  ViewController.swift
//  TheOtherSide
//
//  Created by Kelly Lampotang on 12/16/15.
//  Copyright © 2015 KW. All rights reserved.
//

import UIKit
import GoogleMaps


class ViewController: UIViewController, GMSMapViewDelegate,CLLocationManagerDelegate

 {
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var WhereAmI: UIButton!
    
    /*override func loadView() {
        let panoView = GMSPanoramaView(frame: CGRectZero)
        panoView.delegate = self
        self.view = panoView
        panoView.moveNearCoordinate(CLLocationCoordinate2DMake(0.000, 150.312))
        
    }*/
    
    @IBAction func findMyLocation(sender: UIButton) {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    /*class ViewController: UIViewController {
    */
    override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    }

    
    let locationManager = CLLocationManager()
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
            
            if (error != nil) {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                return
            }
            
            if placemarks!.count > 0 {
                let pm = placemarks![0] 
                self.displayLocationInfo(pm)
                self.reverseRGC(pm)
                
            } else {
                print("Problem with the data received from geocoder")
            }
        })
    }
    func reverseRGC(placemark: CLPlacemark?) {
        if let currPlacemark = placemark {
            locationManager.stopUpdatingLocation()
            var newLat = currPlacemark.location!.coordinate.latitude
            var newLong = currPlacemark.location!.coordinate.longitude
            newLat = newLat * -1
            newLong = newLong + 180
            let location = CLLocation(latitude: newLat, longitude: newLong)
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
                
                //print(location)
                if error != nil {
                    print("Reverse geocoder failed with error" + error!.localizedDescription)
                    return
                }
                
                if placemarks!.count > 0 {
                    let pm = placemarks![0] 
                    print(pm.locality)
                }
                else {
                    print("Problem with the data received from geocoder")
                }
            })
            print("New Latitude: ")
            print(newLat)
            print("New Longitude: ", newLong)
            
        }
    }
    func displayLocationInfo(placemark: CLPlacemark?) {
        if let containsPlacemark = placemark {
            //stop updating location to save battery life
            locationManager.stopUpdatingLocation()
            
            let locality = (containsPlacemark.locality != nil) ? containsPlacemark.locality : ""
            let postalCode = (containsPlacemark.postalCode != nil) ? containsPlacemark.postalCode : ""
            let administrativeArea = (containsPlacemark.administrativeArea != nil) ? containsPlacemark.administrativeArea : ""
            let country = (containsPlacemark.country != nil) ? containsPlacemark.country : ""
            print(containsPlacemark.location!.coordinate.latitude)
            print(containsPlacemark.location!.coordinate.longitude)
            print(locality)
            print(postalCode)
            print(administrativeArea)
            print(country)
            self.city.text = locality
            self.state.text = administrativeArea
            self.country.text = country
            
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error while updating location " + error.localizedDescription)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ViewController: GMSPanoramaViewDelegate {
    func panoramaView(view: GMSPanoramaView!, error: NSError!, onMoveNearCoordinate coordinate: CLLocationCoordinate2D) {
        print("\(coordinate.latitude) \(coordinate.longitude) not available")
        //performSegueWithIdentifier("ErrorSegue", sender: nil)
        
    }
    
}


