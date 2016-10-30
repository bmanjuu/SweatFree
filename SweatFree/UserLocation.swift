//
//  UserLocation.swift
//  SweatFree
//
//  Created by Betty Fung on 10/25/16.
//  Copyright © 2016 Betty Fung. All rights reserved.
//

import Foundation
import CoreLocation

class UserLocation: NSObject, CLLocationManagerDelegate {
    
    static func obtainUserLocationCoordinates() {
        // from core location
    }
    
    static func obtainZipcodeFromCoordinates() {
        //from geocoding api 
    }
    
    static func obtainUserCoordinates(zipcode: String) -> (Double, Double) {
        var userCoordinates : (Double, Double) = (0.00, 0.00)
        
        
        return userCoordinates
    }
}
