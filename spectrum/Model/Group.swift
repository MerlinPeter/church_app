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

class Group: NSObject {
    
    let key: String
    var date: Int
    var groupDescription: String
    var status: GROUP_STATUS
    var imageUrl: String
    var title: String
    let ref: DatabaseReference?
    
    init(imageUrl: String, title: String  ,eventDescription: String,date: Int , status :GROUP_STATUS ,key: String = ""){
        
        self.imageUrl = imageUrl
        self.title = title
        self.groupDescription = eventDescription
        self.date = date
        self.ref = nil
        self.key = key
        self.status = status
        
    }
    
    
    init?(snapshot: DataSnapshot) {
        key = snapshot.key
        guard let snapshotValue = (snapshot.value as? [String: AnyObject]) else { return nil }
        imageUrl = snapshotValue["imgUrl"] as! String
        title = snapshotValue["title"] as? String ?? ""
        status = snapshotValue["status"] as? GROUP_STATUS ??  GROUP_STATUS.unknown
        groupDescription = snapshotValue["description"] as? String ?? ""
        date = snapshotValue["date"] as! Int
        ref = snapshot.ref
    }
    
    
    func toAnyObject() -> Any {
        return [
            "date": date,
            "description": groupDescription,
            "imgUrl": imageUrl,
            "title": title,
            "status": status
         ]
    }
    
    
}
extension Group {
    func stringActDate()->String{
        //  return ModelHelper.dateFunction_1(timeStamp: self.date)
        return "TBD"
    }
}

