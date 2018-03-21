//
//  MeetupModel.swift
//  iOSHackathon3
//
//  Created by john bradley on 3/20/18.
//  Copyright © 2018 TeamQuickDraw. All rights reserved.
//

import Foundation
class MeetupModel {
    static func getTechMeetups(completionHandler:@escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        print("getAllTech")
        let url = URL(string: "https://api.meetup.com/2/open_events?and_text=False&offset=0&format=json&lon=-121.91098&limited_events=False&topic=technology-startups&photo-host=public&page=20&radius=20&lat=37.375359&desc=False&status=upcoming&sig_id=204076643&sig=b216ed66f7b68bbd3b99e0ce6faaf643d71c208d")
        let session = URLSession.shared
        let task = session.dataTask(with: url!, completionHandler: completionHandler)
        task.resume()
    }
}

