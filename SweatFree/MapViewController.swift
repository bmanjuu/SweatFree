//
//  MapViewController.swift
//  SweatFree
//
//  Created by Betty Fung on 10/21/16.
//  Copyright © 2016 Betty Fung. All rights reserved.
//

import UIKit
import Mapbox
import MapboxDirections

class MapViewController: UIViewController, MGLMapViewDelegate {

    @IBOutlet var mapView: MGLMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        mapView.delegate = self
        
        mapView.showsUserLocation = true
        //future update: center coordinate should == user location (grab using core location framework maybe? or have option to put in zipcode)
        
        mapView.zoomLevel = 15
        mapView.centerCoordinate = CLLocationCoordinate2D(latitude: 40.721898, longitude: -73.962135)
        
        let point = MGLPointAnnotation()
        point.coordinate = CLLocationCoordinate2D(latitude: 40.721898, longitude: -73.962135)
        point.title = "Smorgasburg"
        point.subtitle = "90 Kent Ave, Brooklyn, NY 11211"
        
        mapView.addAnnotation(point)
        
        drawRoute()
        
    }
    
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        // Always try to show a callout when an annotation is tapped.
        return true
    }
    
    
    func drawRoute() {
        let directions = Directions(accessToken: "\(Secrets.mapboxToken)")
        
        let waypoints = [
            Waypoint(coordinate: CLLocationCoordinate2D(latitude: 40.721898, longitude: -73.962135), name: "Smorgasburg"),
            Waypoint(coordinate: CLLocationCoordinate2D(latitude: 40.717701, longitude: -73.956528), name: "El Almacén"),
            ]
        
        let options = RouteOptions(waypoints: waypoints, profileIdentifier: MBDirectionsProfileIdentifierAutomobile)
        options.includesSteps = true
        
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
                
                if route.coordinateCount > 0 {
                    // Convert the route’s coordinates into a polyline.
                    var routeCoordinates = route.coordinates!
                    let routeLine = MGLPolyline(coordinates: &routeCoordinates, count: route.coordinateCount)
                    
                    // Add the polyline to the map and fit the viewport to the polyline.
                    self.mapView.addAnnotation(routeLine)
                    self.mapView.setVisibleCoordinates(&routeCoordinates, count: route.coordinateCount, edgePadding: UIEdgeInsets.zero, animated: true)
                }
            }
        }

        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
