//
//  EventbriteAPIClient.swift
//  SweatFree
//
//  Created by Betty Fung on 10/21/16.
//  Copyright © 2016 Betty Fung. All rights reserved.
//

import Foundation

struct EventbriteAPIClient {
    
    static var store = FitnessEventDataStore.sharedInstance
    
    // typealias fitnessEventCompletion = (FitnessEvent, Error?) ->()
    
    static func getFreeFitnessEvents(location: String, completion: @escaping (FitnessEvent) -> ()) {
        
        //location will be zipcode, use mapbox libraries to get coordinates, directions, and display map
        
        let session = URLSession.init(configuration: .default)
        
        let fitnessEventURLString = "https://www.eventbriteapi.com/v3/events/search/\(Secrets.eventbriteToken)&location.address=\(location)&categories=107,108&price=free&formats=9,15"
        guard let fitnessEventURL = URL(string: fitnessEventURLString) else {
            print("could not unwrap fitness event url string")
            return
        }
        let request = URLRequest(url: fitnessEventURL)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            //request.httpMethod = "GET"
            
            if let data = data {
                do {
                    if let responseData = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                        
                        guard let
                            events = responseData["events"] as? [NSDictionary],
                            let testEvent = events[0] as? [String: AnyObject],
                            let testEventNameInfo = testEvent["name"] as? [String:String],
                            let testEventName = testEventNameInfo["text"]
                            //                            let testEventOrganization = testEvent["organizer_id"] as? String,
                            //                            let testEventLocation = testEvent["venue_id"] as? String
                            else {
                                print("could not obtain event information")
                                return
                        }
                        
                        let testFitnessEvent = FitnessEvent(name: testEventName, organization: "SweatFree Test", address: "11 Broadway, New York, NY", date: NSDate())
                        self.store.fitnessEvents.append(testFitnessEvent)
                        print("TEST FITNESS EVENT: \(testFitnessEvent)")
                        
                        completion(testFitnessEvent)
                    }
                } catch {
                    print("could not get fitness events in the area: \(location)")
                }
            }
        }
        
        task.resume()
    }
    
}
