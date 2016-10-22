//
//  MapboxDirectionsAPIClient.swift
//  SweatFree
//
//  Created by Betty Fung on 10/21/16.
//  Copyright © 2016 Betty Fung. All rights reserved.
//

import Foundation
import MapboxDirections

struct MapboxDirectionsAPIClient {
    
    static func getDirectionsToEvent(userLocation: (latitude: Double, longitude:Double), destination: (latitude: Double, longitude: Double)) {
        
        let directionsURLString = "https://api.mapbox.com/directions/v5/mapbox/driving/\(userLocation.latitude)%2C\(userLocation.longitude)%3B\(destination.longitude)%2C\(destination.longitude).json?access_token=\(Secrets.mapboxToken)"
    }
    
    
    
}
