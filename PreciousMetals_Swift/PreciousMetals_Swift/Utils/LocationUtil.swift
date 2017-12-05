//
//  LocationUtil.swift
//  PreciousMetals_Swift
//
//  Created by hazik on 2017/6/22.
//  Copyright © 2017年 ksjf. All rights reserved.
//

import UIKit
import CoreLocation

public protocol LocationDelegate : NSObjectProtocol {
    func locationDidUpdatingStart()
    func locationDidUpdatingStop()
    func locationDidSuccessResult(_ longitude: Double, _ latitude: Double)
    func locationDidSuccessResult(_ longitude: Double, _ latitude: Double, _ country: String, _ state: String, _ city: String, _ countryCode: String)
    func locationDidSuccessResult(_ longitude: Double, _ latitude: Double, _ info: [AnyHashable : Any]?)
    func locationDidError(_ error: Error)
}

extension LocationDelegate {
    func locationDidUpdatingStart(){}
    func locationDidUpdatingStop(){}
    func locationDidSuccessResult(_ longitude: Double, _ latitude: Double){}
    func locationDidSuccessResult(_ longitude: Double, _ latitude: Double, _ country: String, _ state: String, _ city: String, _ countryCode: String){}
    func locationDidSuccessResult(_ longitude: Double, _ latitude: Double, _ info: [AnyHashable : Any]?){}
    func locationDidError(_ error: Error){}
}

class LocationUtil: NSObject, CLLocationManagerDelegate, LocationDelegate {
    public static let INSTANCE = LocationUtil()
    
    private var delegate:LocationDelegate?
    
    private let manager:CLLocationManager
    
    private override init() {
        manager = CLLocationManager()
        super.init()
        manager.delegate = self
    }
    
    public func start() {
        start(self)
    }
    
    public func start(_ delegate: LocationDelegate) {
        self.delegate = delegate
        delegate.locationDidUpdatingStart()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    public func stop() {
        manager.stopUpdatingLocation()
        delegate?.locationDidUpdatingStop()
        self.delegate = nil
    }
    
    /* CLLocationManagerDelegate */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        
        let longitude = location.coordinate.longitude
        let latitude = location.coordinate.latitude
        self.delegate?.locationDidSuccessResult(longitude, latitude)
        
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks:[CLPlacemark]?, error:Error?) in
            if error != nil {
                self.delegate?.locationDidError(error!)
                self.stop()
                return;
            }
            if placemarks == nil || (placemarks?.count)! < 1 {
                self.stop()
                return;
            }
            let placemark = placemarks?.first
            let countryCode = placemark?.isoCountryCode
            let country = placemark?.country
            let state = placemark?.administrativeArea;
            var city = placemark?.locality;
            if nil == city || 0 == city?.lengthOfBytes(using: String.Encoding.utf8) {
                city = placemark?.administrativeArea;
            }
            self.delegate?.locationDidSuccessResult(longitude, latitude, placemark?.addressDictionary)
            self.delegate?.locationDidSuccessResult(longitude, latitude, country!, state!, city!, countryCode!)
            self.stop()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.delegate?.locationDidError(error)
        stop()
    }
    
    //MARK: - LocationDelegate
    func locationDidSuccessResult(_ longitude: Double, _ latitude: Double) {
        DeviceInfo.INSTANCE.longitude = String(longitude)
        DeviceInfo.INSTANCE.latitude = String(latitude)
    }
    func locationDidSuccessResult(_ longitude: Double, _ latitude: Double, _ country: String, _ state: String, _ city: String, _ countryCode: String) {
        DeviceInfo.INSTANCE.country = country
        DeviceInfo.INSTANCE.state = state
        DeviceInfo.INSTANCE.city = city
        DeviceInfo.INSTANCE.gpsCountryCode = countryCode
    }
    
    func locationDidError(_ error: Error) {
        let err:NSError = error as NSError
        DeviceInfo.INSTANCE.gpsErrorCode = err.code
    }
}
