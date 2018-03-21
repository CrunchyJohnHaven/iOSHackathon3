//
//  NatalieViewController.swift
//  iOSHackathon3
//
//  Created by john bradley on 3/20/18.
//  Copyright © 2018 TeamQuickDraw. All rights reserved.
//

import UIKit

class NatalieViewController: UIViewController {

    @IBOutlet weak var eventNameLabel: UILabel!

    @IBOutlet weak var meetupNameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var timePlaceLabel: UILabel!
    
    
    @IBAction func returnButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
