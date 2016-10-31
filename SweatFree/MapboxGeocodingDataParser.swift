//
//  MapboxGeocodingDataParser.swift
//  SweatFree
//
//  Created by Betty Fung on 10/31/16.
//  Copyright © 2016 Betty Fung. All rights reserved.
//

import Foundation

struct MapboxGeocodingDataParser {
    
    static let store = UserDataStore.sharedInstance
    
    static func getUserLocationCoordinates(userZipcode: String, zipcodeResults: [[String:AnyObject]]) -> Location {
        
        var zipcodeInformation = [String:AnyObject]()
        
        for result in zipcodeResults {
            guard let filterCountryResults = result["context"] as? [[String:AnyObject]],
            let country = filterCountryResults.last as? [String:String]
                else {
                    print("could not get country information from response data")
                    return Location()
                }
            
            if country["short_code"] == "us" {
                zipcodeInformation = result
                print("\n\n\nzipcode info: \n\(zipcodeInformation)\n\n\n")
                break
            }
        }
        
        guard let coordinateInfo = zipcodeInformation["geometry"] as? [String:AnyObject],
            let coordinates = coordinateInfo["coordinates"] as? [Double]
        else {
            print("could not obtain coordinate info from geometry part of response")
            return Location()
        }
        
        let userLocation = Location(name: "\(userZipcode)", coordinates: (coordinates[1], coordinates[0]), description: "my location")
        self.store.user.location = userLocation
        
        print("***** USER LOCATION INFORMATION ******")
        print("name/zipcode: \(self.store.user.location!.name)")
        print("coordinates: \(self.store.user.location!.coordinates)")
        print("description: \(self.store.user.location!.description)")
        print("**************************************")
        
        return userLocation
    }
    
}
