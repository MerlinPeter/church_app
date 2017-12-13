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

class Message: NSObject {
    
    let key: String
    var date: Int
    var message: String
    var imageUrl: String
    var author: String
     let ref: DatabaseReference?
    
    init(imageUrl: String, message: String  ,author: String,date: Int  ,key: String = ""){
        
        self.imageUrl = imageUrl
        self.message = message
        self.author = author
        self.date = date
        self.ref = nil
        self.key = key
        
    }
    
    
    init?(snapshot: DataSnapshot) {
        key = snapshot.key
        guard let snapshotValue = (snapshot.value as? [String: AnyObject]) else { return nil }
        imageUrl = snapshotValue["imgUrl"] as! String
        message = snapshotValue["message"] as? String ?? ""
        author = snapshotValue["author"] as? String ?? ""
        date = snapshotValue["date"] as! Int
        ref = snapshot.ref
    }
    
    
    
    func toAnyObject() -> Any {
        return [
            "date": date,
            "message": message,
            "imgUrl": imageUrl,
            "author": author
            
        ]
    }
    
    
}
extension Message {
    func stringActDate()->String{
      //  return ModelHelper.dateFunction_1(timeStamp: self.date)
        return "TBD"
    }
}
