//
//  ViewController.swift
//  FindMyLocation
//
//  Created by HalseyW-15 on 2018/12/20.
//  Copyright © 2018 wushhhhhh. All rights reserved.
//
//知识点：
//1. UILabel实现自适应高度：将UILabel嵌套在UIView中，把UIView的高度设为>=n，并将UILabel的lines设置为0。
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    override var preferredStatusBarStyle: UIStatusBarStyle {return .lightContent}
    @IBOutlet weak var labelLocation: UILabel!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
    }

    @IBAction func onClickFindMyLocationButton(_ sender: UIButton) {
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        labelLocation.text = "Error while updating location" + error.localizedDescription
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!) { (placemarksArray, error) in
            if error != nil {
                self.labelLocation.text = "Reverse geocoder failed with error" + error!.localizedDescription
                return
            }
            if let placemarks = placemarksArray, placemarks.count > 0 {
                self.showLocation(with: placemarks[0])
            } else {
                self.labelLocation.text = "Problem with the data received from geocoder"
            }
        }
    }
    
    func showLocation(with placemark: CLPlacemark) {
        locationManager.stopUpdatingLocation()
        
        let locality = placemark.locality != nil ? placemark.locality : ""
        let postalCode = placemark.postalCode != nil ? placemark.postalCode : ""
        let administrativeArea = placemark.administrativeArea != nil ? placemark.administrativeArea : ""
        let country = placemark.country != nil ? placemark.country : ""
        
        labelLocation.text = country! + "," + administrativeArea!
        labelLocation.text?.append("\n" + postalCode! + "" + locality!)
    }
}

