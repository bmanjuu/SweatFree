//
//  MapboxGeocodingAPIClient.swift
//  SweatFree
//
//  Created by Betty Fung on 10/21/16.
//  Copyright © 2016 Betty Fung. All rights reserved.
//

import Foundation

struct MapboxGeocodingAPIClient {
    
    func obtainUserCoordinates(userZipcode: String) {
        
        let mapboxGeocodingURLString = "https://api.mapbox.com/geocoding/v5/mapbox.places/\(userZipcode).json?country=us&access_token=\(Secrets.mapboxToken)"
    }
    
    
    
}
