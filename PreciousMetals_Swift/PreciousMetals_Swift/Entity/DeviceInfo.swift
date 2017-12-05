//
//  DeviceInfo.swift
//  PreciousMetals_Swift
//
//  Created by hazik on 2017/6/15.
//  Copyright © 2017年 ksjf. All rights reserved.
//

import Foundation
import UIKit

class DeviceInfo: NSObject {
    public static let INSTANCE = DeviceInfo()
    
    public let termType: String
    public let ip: String
    public let machineId: String
    public var machineType: String
    public let sysVersion: String
    public let appVersion: String
    public var network: String
    public var isNetworkOK: Bool
    public var sourceType: String
    public var deviceToken: String
    public var registrationID: String
    
    public var gps: String {
        get {
            return longitude + "," + latitude
        }
    }
    public var longitude: String
    public var latitude: String
    public var country: String
    public var state: String
    public var city: String
    public var gpsErrorCode: Int
    public var gpsCountryCode: String
    
    private override init(){
        self.termType = "2";
        self.ip = "";
        self.longitude = "";
        self.latitude = "";
        self.country = "";
        self.state = "";
        self.city = "";
        self.gpsErrorCode = 0;
        self.gpsCountryCode = "";
        
        self.machineId = (UIDevice.current.identifierForVendor?.uuidString)!;
        self.sysVersion = UIDevice.current.systemVersion;
        self.machineType = ""
        let info = Bundle.main.infoDictionary
        appVersion = info?["CFBundleShortVersionString"] as! String
        
        network = ""
        isNetworkOK = false
        sourceType = "0"
        deviceToken = ""
        registrationID = ""
        super.init()
        self.machineType = self.getMachineType()
    }
    
    private func getMachineType() -> String {
        var sysInfo = utsname()
        uname(&sysInfo)
        let machineMirror = Mirror(reflecting: sysInfo.machine)
        
        let identifier = machineMirror.children.reduce("") { result, element in
            guard let value = element.value as? Int8, value != 0 else {
                return result
            }
            return result + String(UnicodeScalar(UInt8(value)))
        }
        
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPhone9,1":                               return "iPhone 7"
        case "iPhone9,2":                               return "iPhone 7 Plus"
        case "iPhone10,1" :                             return "iPhone 8"
        case "iPhone10,2" :                             return "iPhone 8 Plus"
        case "iPhone10,3" :                             return "iPhone X"
        case "iPhone10,4" :                             return "iPhone 8"
        case "iPhone10,5" :                             return "iPhone 8 Plus"
        case "iPhone10,6" :                             return "iPhone X"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
}
