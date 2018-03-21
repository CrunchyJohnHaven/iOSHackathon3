//
//  NatalieViewController.swift
//  iOSHackathon3
//
//  Created by john bradley on 3/20/18.
//  Copyright © 2018 TeamQuickDraw. All rights reserved.
//

import UIKit

class NatalieViewController: UIViewController {

    var location: Artwork?
    var delegate: JohnDelegate?
    var meetupTitle: String = "title"
    var meetupAddress: String = "Address"
    var meetupLocation: String = "location"
    var meetupTime: String = "time"
    var meetupCity: String = "City"
    var meetupUrl: String = "URL"
    

    @IBAction func backButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBOutlet weak var eventNameLabel: UILabel!

    @IBOutlet weak var meetupNameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var timePlaceLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("VIEWDIDLOAD")
//        self.meetupAddress = self.location!.address
//        self.meetupTitle = "\(self.location!.title!)"
        eventNameLabel.text = self.location?.title!
        meetupNameLabel.text = self.location?.who
        timePlaceLabel.text = self.location?.time
        addressLabel.text = self.location?.address
        self.meetupTime = (self.location?.time)!
        self.meetupCity = (self.location?.city)!
        self.meetupAddress = (self.location?.address)!
        self.meetupUrl = (self.location?.event_url)!
        
        
        
        descriptionLabel.text = "This meetup is taking place in \(self.meetupCity) on \(self.meetupTime). It is hosted by \(self.meetupLocation) at \(self.meetupAddress). For more information and to join the event go to \(self.meetupUrl)"
        
        



//        print(delegate.meetupData)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // ======== add to john's controller page. =======
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let navController = segue.destination as! UINavigationController
//        let natViewController = navController.JohnViewController as! NatalieViewController
//    }
    

}
