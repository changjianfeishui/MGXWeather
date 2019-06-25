//
//  LocationManager.swift
//  MGXWeather
//
//  Created by Miu on 2019/4/12.
//  Copyright © 2019 MGX. All rights reserved.
//

import UIKit
import CoreLocation
class LocationManager: NSObject {
    private let clMgr = CLLocationManager()
    private let geoCoder = CLGeocoder()
    var completionHandler: ((CLLocation?,Error?)->Void)? = nil
    public func start(completionHandler: @escaping (CLLocation?,Error?) -> Void) -> Void {
        let status = CLLocationManager.authorizationStatus()
        if status == .notDetermined {
            clMgr.requestWhenInUseAuthorization()
        }
        self.completionHandler = completionHandler
        clMgr.delegate = self
        clMgr.startUpdatingLocation()
    }
}

extension LocationManager:CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        let location = locations.last
        geoCoder.reverseGeocodeLocation(location!) { (placemark, error) in
            if let place = placemark?.first {
                var cityName:String;
                if let subLocality = place.subLocality {
                    cityName = subLocality
                }else if let locality = place.locality{
                    cityName = locality
                }else if let name = place.name{
                    cityName = name
                }else {
                    cityName = place.country ?? "Error"
                }
                NotificationCenter.default.post(name: NSNotification.Name.LocationCLGeocoderSuccess, object: cityName)
            }
        }
        if let completionHandler = completionHandler {
            completionHandler(location,nil)
            self.completionHandler = nil
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completionHandler!(nil,error)
    }
}
