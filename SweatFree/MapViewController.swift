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

class MapViewController: UIViewController, MGLMapViewDelegate, CLLocationManagerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        
        let mapView = createMapView()
        let startCoordinate = currentUserLocation(mapView: mapView, locationManager: locationManager)
        let endCoordinate = CLLocationCoordinate2D(latitude: 40.700454, longitude: -73.996657) //this is default end coordinate, should be replaced with the locations of different events
        addAnnotationFor(mapView: mapView, annotationCoordinate: endCoordinate)
        
        
        view.addSubview(mapView)
        
        drawRoute(map: mapView, startCoordinate: startCoordinate, endCoordinate: endCoordinate)
        
    }
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        // Always try to show a callout when an annotation is tapped.
        return true
    }
    
    func createMapView() -> MGLMapView {
        let mapView = MGLMapView(frame: view.bounds,
                                 styleURL: MGLStyle.outdoorsStyleURL(withVersion: 9))
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.tintColor = colorPalette.purple
        mapView.setCenter(CLLocationCoordinate2D(latitude: 40.700454, longitude: -73.996657), zoomLevel: 12, animated: false)
        mapView.delegate = self
        
        return mapView
    }
    
    func currentUserLocation(mapView: MGLMapView, locationManager: CLLocationManager) -> CLLocationCoordinate2D {
        mapView.showsUserLocation = true
        print("current user location from map: \(mapView.userLocation!.coordinate)")
        print("CLLocation manager user location: \(locationManager.location!.coordinate)")
        let startCoordinate = locationManager.location!.coordinate
        //need to obtain user coordinates using CLLocation manager not mapView user location coordinates! otherwise, get weird results from coordinates
        
        return startCoordinate
    }
    
    func addAnnotationFor(mapView: MGLMapView, annotationCoordinate: CLLocationCoordinate2D) {
        
        let point = MGLPointAnnotation()
        point.coordinate = annotationCoordinate
        
        point.title = "Brooklyn Bridge Park"
        point.subtitle = "334 Furman St, Brooklyn, NY 11201"
        //will need to adjust these according to which event the user selects
        
        mapView.addAnnotation(point)
    }
    
    
    
    
    func drawRoute(map: MGLMapView, startCoordinate: CLLocationCoordinate2D, endCoordinate: CLLocationCoordinate2D) {
        
        let directions = Directions(accessToken: "\(Secrets.mapboxToken)")
        
        print("drawRoute function called")
        print("start coordinate: \(startCoordinate)")
        print("end coordinate: \(endCoordinate)")
        
        let waypoints = [
            Waypoint(coordinate: startCoordinate, name: "start"),
            Waypoint(coordinate: endCoordinate, name: "end"),
            ]
        
        //change profileIdentifier in options according to distance: walking for < 1 mile and driving/cycling for everything else ... or give user the option to choose!
        
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
                    map.addAnnotation(routeLine)
                    map.setVisibleCoordinates(&routeCoordinates, count: route.coordinateCount, edgePadding: UIEdgeInsets.zero, animated: true)
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
