//
//  Event.swift
//  spectrum
//
//  Created by Merlin Ahila on 12/3/17.
//  Copyright © 2017 Merlin Ahila. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class Event: NSObject {
    
    let key: String
    var date: Int
    var eventDescription: String
    var imageUrl: String
    var title: String
     let ref: DatabaseReference?
    
    init(imageUrl: String, title: String  ,eventDescription: String,date: Int  ,key: String = ""){
        
        self.imageUrl = imageUrl
        self.title = title
        self.eventDescription = eventDescription
        self.date = date
         self.ref = nil
        self.key = key
        
    }
    
    
    init?(snapshot: DataSnapshot) {
        key = snapshot.key
        guard let snapshotValue = (snapshot.value as? [String: AnyObject]) else { return nil }
        imageUrl = snapshotValue["imgUrl"] as! String
        title = snapshotValue["title"] as? String ?? ""
        eventDescription = snapshotValue["description"] as? String ?? ""
        date = snapshotValue["date"] as! Int
        ref = snapshot.ref
    }
    
    
    
    func toAnyObject() -> Any {
        return [
            "date": date,
            "description": eventDescription,
            "imgUrl": imageUrl,
            "title": title
            
        ]
    }
    
    
}
extension Event {
    func stringActDate()->String{
      //  return ModelHelper.dateFunction_1(timeStamp: self.date)
        return "TBD"
    }
}

