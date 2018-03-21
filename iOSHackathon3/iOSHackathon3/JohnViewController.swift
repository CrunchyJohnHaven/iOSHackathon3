//
//  ViewController.swift
//  iOSHackathon3
//
//  Created by john bradley on 3/20/18.
//  Copyright © 2018 TeamQuickDraw. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Contacts

class JohnViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    let initialLocation = CLLocation(latitude: 37.3753590, longitude: -121.910980)
    let locationManager = CLLocationManager()
    var location: Artwork?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        let artwork = Artwork(title: "Coding Dojo Silicon Valley",
                              tag: "Click to investigate The Dojo!",
                              discipline: "Home",
                              shortNextClue: "An 'inmate' at The Dojo says MC has friends in the airline industry.",
                              longNextClue: "One of the Dojo inmates has little love for MC and his cryptic online tutorials. He tells you that he overheard MC mention a friend in the airline industry. That will be enough to go off of.",
                              eventDescription: "Your services have been enlisted to find the notorious fugitive 'MC' who has recently escaped from his dojo prison. What drives this fugitive? Where is he going? Whatever it is, you have received your first clue.",
                              identifyer: 1,
                              coordinate: CLLocationCoordinate2D(latitude: 37.3753590, longitude: -121.910980))
        mapView.addAnnotation(artwork)
        
        centerMapOnLocation(location: initialLocation)
    mapView.delegate = self

    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                let location = locations[0]
                let center = location.coordinate
                let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                let region = MKCoordinateRegion(center:center, span:span)
                mapView.setRegion(region, animated: true)
                mapView.showsUserLocation = true

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
extension JohnViewController: MKMapViewDelegate {
    // 1 - gets called for every annotation added
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 2
        guard let annotation = annotation as? Artwork else { return nil }
        // 3
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 5
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
}
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        
        self.location = view.annotation as? Artwork
        print("tapped")
        performSegue(withIdentifier: "ShowClue", sender: Any?.self)
        print("self.location.longNextClue: ",self.location?.longNextClue as Any)
        print("location.description: ", self.location?.description as Any)
        print("self.location.title: ", self.location?.title! as Any)
        print("self.location.identifyer: ", self.location?.identifyer as Any)
        print("self.location.discipline: ", self.location?.discipline as Any)
        print("self.location.coordinate: ", self.location?.coordinate as Any)
        print("self.location.tag: ", self.location?.tag as Any)
        
    }
}

