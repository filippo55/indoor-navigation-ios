# Indoor navigation for visually impaired in Swift

## Setting up a your location using Estimote Indoor SDK

In order to construct a new location you need to:

- set the shape of the location and its orientation
- add details such as beacons, walls, doors on boundary segments

The shape of the location is defined by its boundary points. For example, consider a square defined by points (0,0), (0,5), (5,5), (5,0) along with its orientation with respect to magnetic north.

```swift
let locationBuilder = EILLocationBuilder()
 locationBuilder.setLocationBoundaryPoints([
            EILPoint(x: 0.00, y: 0.00),
            EILPoint(x: 5.00, y: 0.00),
            EILPoint(x: 5.00, y: 13.00),
            EILPoint(x: 0.00, y: 13.00)])
            
locationBuilder.setLocationOrientation(50)
```

The next step is to place beacons 

```swift
 locationBuilder.addBeacon(withIdentifier: "YOUT_IDENTIFIER", withPosition: EILOrientedPoint(x:0,y:0,orientation:180), andColor: ESTColor.coconutPuff)
```

Obtaining position update inside the location

Once you have instance of ```EILLocation``` you can start monitoring and obtaining position updates for that location.

Monitoring location is simply determining if the user is currently inside or outside the location. In order to monitor location, first you need to create instance of ```EILIndoorLocationManager```.

```swift
locationManager = EILIndoorLocationManager()
```

To obtain position updates, you need to set a ```delegate``` which will be receiving the updates.

```swift
locationManager.delegate = self
locationManager.startPositionUpdates(for: location)
```
