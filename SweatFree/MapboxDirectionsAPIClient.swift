//
//  MapboxDirectionsAPIClient.swift
//  SweatFree
//
//  Created by Betty Fung on 10/21/16.
//  Copyright © 2016 Betty Fung. All rights reserved.
//

import Foundation
import Mapbox
import MapboxDirections

struct MapboxDirectionsAPIClient {
    
    static let directions = Directions(accessToken: "\(Secrets.mapboxToken)")
    
    static let waypoints = [
        Waypoint(coordinate: CLLocationCoordinate2D(latitude: 38.9131752, longitude: -77.0324047), name: "Mapbox"),
        Waypoint(coordinate: CLLocationCoordinate2D(latitude: 38.8977, longitude: -77.0365), name: "White House"),
        ]
    
    static let setRouteOptions = RouteOptions(waypoints: waypoints, profileIdentifier: MBDirectionsProfileIdentifierAutomobile)
    static var options : RouteOptions {
        setRouteOptions.includesSteps = true
        return setRouteOptions
    }
    
    let task = directions.calculateDirections(options) { (waypoints, routes, error) in
        guard error == nil else {
            print("Error calculating directions: \(error!)")
            return
        }
        
        if let route = routes?.first, let leg = route.legs.first {
            print("Route via \(leg):")
            
            let distanceFormatter = LengthFormatter()
            let formattedDistance = distanceFormatter.string(fromMeters: route.distance)
            
            let travelTimeFormatter = DateComponentsFormatter()
            travelTimeFormatter.unitsStyle = .short
            let formattedTravelTime = travelTimeFormatter.string(from: route.expectedTravelTime)
            
            print("Distance: \(formattedDistance); ETA: \(formattedTravelTime!)")
            
            for step in leg.steps {
                print("\(step.instructions)")
                let formattedDistance = distanceFormatter.string(fromMeters: step.distance)
                print("— \(formattedDistance) —")
            }
            
        }
    }
    

    
//    static func getDirectionsToEvent(userLocation: (latitude: Double, longitude:Double), destination: (latitude: Double, longitude: Double)) {
//        
//        let directionsURLString = "https://api.mapbox.com/directions/v5/mapbox/driving/\(userLocation.latitude)%2C\(userLocation.longitude)%3B\(destination.longitude)%2C\(destination.longitude).json?access_token=\(Secrets.mapboxToken)"
//    }
    
    
    
}
