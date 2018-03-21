//
//  Artwork.swift
//  iOSHackathon3
//
//  Created by john bradley on 3/20/18.
//  Copyright © 2018 TeamQuickDraw. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Contacts

class Artwork: NSObject, MKAnnotation {
    let title: String?
    let city: String
    let address: String
    let desc: String
    let who: String
    let time: String
    let event_url: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, city: String, address: String, desc: String, who: String, time: String, event_url: String,  coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.city = city
        self.address = address
        self.desc = desc
        self.who = who
        self.time = time
        self.event_url = event_url
        
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return desc
    }
    ///!!!! OPENING MAPS - create MKMapItem from an MKPlacemark
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
}
