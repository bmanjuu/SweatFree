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
    
//    static var userZipcode : String = "10010" //default zipcode
//    static var userCoordinates = User(coordinates: (0.00, 0.00)) //default coordinates
    
    enum MapboxGeocodingAPIError: Error {
        case InvalidJSONDictionaryCast
        case InvalidDictionaryResponseKey
        case InvalidDictionaryDocsKey
    }
    
    
    typealias MapboxGeocodingCompletion = (User, Error?) -> ()
    
    
    func zipcodeSearchWithCompletion(userLocationZipcode: String, completion: @escaping MapboxGeocodingCompletion) {
        
        let mapboxGeocodingURLString = "https://api.mapbox.com/geocoding/v5/mapbox.places/\(userLocationZipcode).json?country=us&access_token=\(Secrets.mapboxToken)"
        guard let mapboxGeocodingURL = URL(string: mapboxGeocodingURLString) else {
            print("could not unwrap mapbox geocoding url string")
            return
        }
        
      
        Alamofire.request(mapboxGeocodingURL).responseJSON { response in
            
            var zipcodeSearchResults = [[String:AnyObject]]()
            
            switch response.result {
                
                case .failure(let error):
                    completion(User(), error)
                
                case .success(let value):
                    guard let zipcodeResponse = value as? NSDictionary else { completion(User(), MapboxGeocodingAPIError.InvalidJSONDictionaryCast); return }
                    guard let zipcodeArray = zipcodeResponse["features"] as? [[String:AnyObject]] else { completion(User(), MapboxGeocodingAPIError.InvalidDictionaryResponseKey)
                        return }
                
                zipcodeSearchResults = zipcodeArray
            }
            
            completion(MapboxGeocodingDataParser.getUserLocationCoordinates(zipcodeResults: zipcodeSearchResults), nil)
            
        }
    }
}
