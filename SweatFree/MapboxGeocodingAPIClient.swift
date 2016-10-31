//
//  MapboxGeocodingAPIClient.swift
//  SweatFree
//
//  Created by Betty Fung on 10/21/16.
//  Copyright © 2016 Betty Fung. All rights reserved.
//

import Foundation

struct MapboxGeocodingAPIClient {
    
    //change coordinates of drawRoute function in MapViewVC according to the user and destination coordinates obtained here
    
    static var userZipcode : String = "10010" //default zipcode
    static var userCoordinates : (Double, Double) = (0.00, 0.00) //default coordinates
    
    enum MapboxGeocodingAPIError: Error {
        case InvalidJSONDictionaryCast
        case InvalidDictionaryResponseKey
        case InvalidDictionaryDocsKey
    }
    
    
    typealias MapboxGeocodingCompletion = ([[String:AnyObject]], Error?) -> ()
    
    
    func zipcodeSearchWithCompletion(userLocationZipcode: String, completion: @escaping MapboxGeocodingCompletion) {
        
        let mapboxGeocodingURLString = "https://api.mapbox.com/geocoding/v5/mapbox.places/\(userLocationZipcode).json?country=us&access_token=\(Secrets.mapboxToken)"
        
        guard let mapboxGeocodingURL = URL(string: mapboxGeocodingURLString) else {
            print("could not unwrap mapbox geocoding url string")
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: mapboxGeocodingURL, completionHandler: {
            (data, response, error) in
            
            var zipcodeSearchResults = [[String:AnyObject]]()
            
            if let data = data {
                if let responseData = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    
                    if let zipcodeData = responseData {
                        guard let zipcodeResults = zipcodeData["features"] as? [[String:AnyObject]]
                            else {
                                print("could not unwrap zipcode results from data")
                                return
                        }
                        
                        completion(zipcodeResults)
                    }
                    
                } else { print("error: could not unwrap response data") }
            } else if let error = error {
                print("error: could not obtain data from request - \(error.localizedDescription)")
            }
        })
        
        task.resume()
    }
}
