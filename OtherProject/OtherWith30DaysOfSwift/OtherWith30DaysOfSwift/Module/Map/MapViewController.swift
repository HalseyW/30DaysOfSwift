//
//  MapViewController.swift
//  OtherWith30DaysOfSwift
//
//  Created by HalseyW-15 on 2019/9/4.
//  Copyright © 2019 wushhhhhh. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    let mapView = MKMapView()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(mapView)
        mapView.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
        }
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
}
