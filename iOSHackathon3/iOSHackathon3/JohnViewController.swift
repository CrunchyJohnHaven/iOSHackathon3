//
//  ViewController.swift
//  iOSHackathon3
//
//  Created by john bradley on 3/20/18.
//  Copyright © 2018 TeamQuickDraw. All rights reserved.
 //https://data.sfgov.org/resource/wwmu-gmzc.json
//https://data.sfgov.org/Culture-and-Recreation/Film-Locations-in-San-Francisco/yitu-d5am
//https://dev.socrata.com/foundry/data.sfgov.org/wwmu-gmzc
//
//"title":"Coding Dojo Silicon Valley", "city": "San Jose", "address": "1920 Zanker Rd #20, San Jose, CA 95112", "desc": "coding Dojo meetup", "who": "Coding Dojo Silicon Valley", "time": "April 3rd", "event_url": "http://www.codingdojo", "lat":"37.3753590", "lon":"-121.910980"

import UIKit
import MapKit
import CoreLocation
import Contacts

class JohnViewController: UIViewController, CLLocationManagerDelegate {
    var meetups: [String] = []
    @IBOutlet weak var mapView: MKMapView!
    let initialLocation = CLLocation(latitude: 37.3753590, longitude: -121.910980)
    let locationManager = CLLocationManager()
    var location: Artwork?
    var showsUserLocation: Bool {
        return true
    }
    var eventName: String = "Name"
    var meetupCity: String  = "San Jose"
    var meetupLat: Double = 37.3753590
    var meetupLon: Double = -121.910980
    var meetupAddress: String = "1920 Zanker Rd #20"
    var meetupName: String = "Name"
    var meetupURL: String = "URL"
    var meetupTime: String = "7:00pm - 12 June"
    
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MeetupModel.getTechMeetups(completionHandler: {data, response, error in
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options:
                    JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    print("run1")
                    if let results = jsonResult["results"] {
                        print("run")
                        let resultsArray = results as! NSArray
                        for i in 0..<resultsArray.count {
                            let resultsDict = resultsArray[i] as! NSDictionary
                            self.eventName = resultsDict["name"] as! String
                            print("event name \(self.eventName)")
                            let groupDict = resultsDict["group"] as! NSDictionary
                            self.meetupName = groupDict["name"] as! String
                            print(self.meetupName)
                            if resultsDict.value(forKey: "venue") != nil {
                                let venueDict = resultsDict["venue"] as! NSDictionary
                                if venueDict.value(forKey: "lon") != nil {
                                    self.meetupLon = (venueDict["lon"] as! Double)
                                }
                                if venueDict.value(forKey: "lat") != nil  {
                                    self.meetupLat = Double(venueDict["lat"] as! Float)
                                }
                                if venueDict.value(forKey: "address_1") != nil  {
                                    self.meetupAddress = venueDict["address_1"] as! String
                                }
                                if venueDict.value(forKey: "city") != nil  {
                                    self.meetupCity = venueDict["city"] as! String
                                }
                                
                                
                            }
                            if resultsDict.value(forKey: "event_url") != nil {
                                let meetupUrl = resultsDict["event_url"] as! String
                            }
                            if resultsDict.value(forKey: "time") != nil {
                                let meetupTime = resultsDict["time"] as! Int

                                
                            }
                            var artwork = Artwork(title: "\(self.eventName)",
                                city: "\(self.meetupCity)",
                                address: "\(self.meetupAddress)",
                                desc: "\(self.meetupTime)",
                                who: "\(self.meetupName)",
                                time: "\(self.meetupTime)",
                                event_url: "\(self.meetupURL)",
                                coordinate: CLLocationCoordinate2D(latitude: self.meetupLat, longitude: self.meetupLon))
                            self.mapView.addAnnotation(artwork)
                        }
                    }
                }
                DispatchQueue.main.async {
                }
            } catch {
                print("something wrong")
            }
        })
    
        locationManager.delegate = self;
        self.mapView.delegate = self;
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        
        let artwork = Artwork(title: "Coding Dojo Silicon Valley",
                              city: "San Jose",
                              address: "1920 Zanker Rd #20, San Jose, CA 95112",
                              desc: "coding Dojo meetup",
                              who: "Coding Dojo Silicon Valley",
                              time: "April 3rd",
                              event_url: "http://www.codingdojo",
                              coordinate: CLLocationCoordinate2D(latitude: 37.3753590, longitude: -121.910980))
        mapView.addAnnotation(artwork)
        
        centerMapOnLocation(location: initialLocation)
    mapView.delegate = self
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//                let location = locations[0]
//                let center = location.coordinate
//                let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//                let region = MKCoordinateRegion(center:center, span:span)
//                mapView.setRegion(region, animated: true)
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
    
//override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    if segue.identifier == "ShowClue" {
//        let navigationController = segue.destination as! UINavigationController
//        let controller = navigationController.topViewController as! ViewControllerTwo
//        controller.delegate = self
//        }
//    }

    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        
        self.location = view.annotation as? Artwork
        print("tapped")
        performSegue(withIdentifier: "ShowClue", sender: Any?.self)
    }
}

extension JohnViewController: ReturnButtonDelegate {
            func returnButton(by controller: UIViewController) {
            dismiss(animated: true, completion: nil)
                print("Pressed")
        }
    }
        
        //        print("self.location.longNextClue: ",self.location?.longNextClue as Any)
//        print("location.description: ", self.location?.description as Any)
//        print("self.location.title: ", self.location?.title! as Any)
//        print("self.location.identifyer: ", self.location?.identifyer as Any)
//        print("self.location.discipline: ", self.location?.discipline as Any)
//        print("self.location.coordinate: ", self.location?.coordinate as Any)
//        print("self.location.tag: ", self.location?.tag as Any)
        


