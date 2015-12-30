//
//  ViewController.swift
//  TheOtherSide
//
//  Created by Kelly Lampotang on 12/16/15.
//  Copyright © 2015 KW. All rights reserved.
//

import UIKit
import GoogleMaps
var oppLat = 0.0
var oppLong = 0.0

//create a global-like variable for the opposite city
struct MyVariables {
   static var oppCity = "SomeString"
}

class ViewController: UIViewController, GMSMapViewDelegate,CLLocationManagerDelegate

 {
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var WhereAmI: UIButton!
    @IBOutlet weak var opploc: UILabel!
    
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
                        self.opploc.text = "Opposite is ocean"
                        MyVariables.oppCity = "ocean"
                        //print("My Variables: " + MyVariables.oppCity)
                    }
                    else {
                        print(pm.locality)
                        
                        let stringCity = pm.locality!
                        var stringFormatted = ""
                        let chars = stringCity.characters
                        for i in chars {
                            if(i == " ") {
                                stringFormatted+="%20"
                            }
                            else
                            {
                                stringFormatted+=String(i)
                            }
                            
                        }
                        MyVariables.oppCity = stringFormatted
                        self.opploc.text = pm.locality
                        //print("My Variables: " + MyVariables.oppCity)
                    }
                    
                }
                else {
                    print("Problem with the data received from geocoder")
                }
            })
            print("New Latitude:", newLat)
            print("New Longitude:", newLong)
            
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
/*
extension ViewController: GMSPanoramaViewDelegate {
    func panoramaView(view: GMSPanoramaView!, error: NSError!, onMoveNearCoordinate coordinate: CLLocationCoordinate2D) {
        print("\(coordinate.latitude) \(coordinate.longitude) not available")
        performSegueWithIdentifier("ErrorSegue", sender: nil)
        
    }
    
}*/


