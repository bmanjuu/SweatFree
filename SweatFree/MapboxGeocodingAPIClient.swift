//
//  MapboxGeocodingAPIClient.swift
//  SweatFree
//
//  Created by Betty Fung on 10/21/16.
//  Copyright © 2016 Betty Fung. All rights reserved.
//

import Alamofire
import Foundation

struct MapboxGeocodingAPIClient {
    
    //change coordinates of drawRoute function in MapViewVC according to the user and destination coordinates obtained here
    
    enum MapboxGeocodingAPIError: Error {
        case InvalidJSONDictionaryCast
        case InvalidDictionaryResponseKey
        case InvalidDictionaryDocsKey
    }
    
    
    typealias MapboxGeocodingCompletion = (Location, Error?) -> ()
    
    
    static func zipcodeSearchWithCompletion(userLocationZipcode: String, completion: @escaping MapboxGeocodingCompletion) {
        
        let mapboxGeocodingURLString = "https://api.mapbox.com/geocoding/v5/mapbox.places/\(userLocationZipcode).json?country=us&access_token=\(Secrets.mapboxToken)"
        guard let mapboxGeocodingURL = URL(string: mapboxGeocodingURLString) else {
            print("could not unwrap mapbox geocoding url string")
            return
        }
        
      
        Alamofire.request(mapboxGeocodingURL).responseJSON { response in
            
            var zipcodeSearchResults = [[String:AnyObject]]()
            
            switch response.result {
                
                case .failure(let error):
                    completion(Location(), error)
                
                case .success(let value):
                    guard let zipcodeResponse = value as? NSDictionary else { completion(Location(), MapboxGeocodingAPIError.InvalidJSONDictionaryCast); return }
                    guard let zipcodeArray = zipcodeResponse["features"] as? [[String:AnyObject]] else { completion(Location(), MapboxGeocodingAPIError.InvalidDictionaryResponseKey)
                        return }
                
                zipcodeSearchResults = zipcodeArray
                print("\n\n\n\n\n\nZIPCODE RESULTS: \n \(zipcodeSearchResults)\n\n\n\n\n\n")
            }
            completion(MapboxGeocodingDataParser.getUserLocationCoordinates(userZipcode: userLocationZipcode, zipcodeResults: zipcodeSearchResults), nil)
            
        }
    }
}
