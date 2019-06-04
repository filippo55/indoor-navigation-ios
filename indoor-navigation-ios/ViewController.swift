//
//  ViewController.swift
//  indoor-navigation-ios
//
//  Created by Filip on 30/05/2019.
//  Copyright © 2019 TSSK. All rights reserved.
//

import UIKit

class ViewController: UIViewController, EILIndoorLocationManagerDelegate{

    @IBOutlet weak var locationView: EILIndoorLocationView!
    
    var locationManager: EILIndoorLocationManager!
    var location: EILLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager = EILIndoorLocationManager()
        //Set the location manager's delegate to receive position update events
        self.locationManager.delegate = self
        self.locationManager.mode = EILIndoorLocationManagerMode.normal
        
        createIndoorMap()
    }
    
    //Store the coordinates or send them to an external server for further analysis, e.g., to create a heatmap.
    func indoorLocationManager(_ manager: EILIndoorLocationManager,
                               didUpdatePosition position: EILOrientedPoint,
                               with positionAccuracy: EILPositionAccuracy,
                               in location: EILLocation) {
        
        print(String(format: "x: %5.2f, y: %5.2f, orientation: %3.0f", position.x, position.y, position.orientation))
        
        //Create coffeeMachine point and trigger actions in certain parts of the space
        let coffeeMachine = EILPoint(x: 2.5, y: 7.2)
        if position.distance(to: coffeeMachine) < 3 {
            // Start brewing coffee

        }
    }
    
    func indoorLocationManager(_ manager: EILIndoorLocationManager,
                               didFailToUpdatePositionWithError error: Error) {
        print("failed to update position: \(error)")
    }
    
    func createIndoorMap(){
        
        //The units the entire Indoor SDK operates with are always metric meters
        
        let locationBuilder = EILLocationBuilder()
        locationBuilder.setLocationName("Our first Map")
        
        //Indoor Location is powered not just by beacons, but also by the multitude of sensors available in your device—including the compass.
        //Because of that, we need to define the magnetic orientation of your space
        //https://forums.estimote.com/t/manual-location-setup-using-estlocationbuilder/1228/12?u=heypiotr
        
        locationBuilder.setLocationOrientation(50)
        
        //Start by drawing the contour of your space by defining its boundary points
        //The origin of the coordinate system, i.e., the (0,0) point, is up to you.
        //Each consecutive boundary point connects to the previous one (the first point connects to the last one), forming a boundary segment.
        //The important implication is: the order in which you define points matters, so pay attention to it!

        locationBuilder.setLocationBoundaryPoints([
            EILPoint(x: 0.00, y: 0.00),
            EILPoint(x: 5.00, y: 0.00),
            EILPoint(x: 5.00, y: 13.00),
            EILPoint(x: 0.00, y: 13.00)])
        
        // TODO: Replace with an identifier of your own beacon
        // You can find the identifiers of your beacons on https://cloud.estimote.com
        locationBuilder.addBeacon(withIdentifier: "YOUR_IDENTIFIER", withPosition: EILOrientedPoint(x:2.5,y:0,orientation:180), andColor: ESTColor.coconutPuff)
        locationBuilder.addBeacon(withIdentifier: "YOUR_IDENTIFIER", withPosition: EILOrientedPoint(x:5,y:6.5,orientation:90), andColor: ESTColor.coconutPuff)
        locationBuilder.addBeacon(withIdentifier: "YOUR_IDENTIFIER", withPosition: EILOrientedPoint(x:2.5,y:13,orientation:0), andColor: ESTColor.coconutPuff)
        locationBuilder.addBeacon(withIdentifier: "YOUR_IDENTIFIER", withPosition: EILOrientedPoint(x:0,y:4,orientation:270), andColor: ESTColor.coconutPuff)
        locationBuilder.addBeacon(withIdentifier: "YOUR_IDENTIFIER", withPosition: EILOrientedPoint(x:0,y:9,orientation:270), andColor: ESTColor.coconutPuff)
        
        // Setting properties - you can find full list of properties on:
        // http://estimote.github.io/iOS-Indoor-SDK/Classes/EILIndoorLocationView.html
        locationView.showTrace = true
        locationView.showBeacons = true
        locationView.showWallLengthLabels=true
        locationView.rotateOnPositionUpdate=false
        
        //Build your location
        location = locationBuilder.build()
        locationView.drawLocation(location)
        locationManager.startPositionUpdates(for: location)
    }

}

