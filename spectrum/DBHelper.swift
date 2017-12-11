//
//  EventHelper.swift
//  spectrum
//
//  Created by Merlin Ahila on 12/8/17.
//  Copyright © 2017 Merlin Ahila. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import Firebase

class DBHelper {
    //MARK:- deReg Handle
    static func removeHandle(handle:UInt?)   {
        guard  let handle = handle else {
            return
        }
        DataService.data_service.FIREBASE_BASE_REF.removeObserver(withHandle: handle)
        
    }
    
    //MARK:-- Insert Event
    static func insertEvent(parent:String, event: Event ,completion: @escaping (Error?, DatabaseReference) -> ())  {
        let key = DataService.data_service.FIREBASE_BASE_REF.child(FIREBASE_CONTSTANTS.eventRoot).child(parent).childByAutoId()
        key.setValue(event.toAnyObject(), withCompletionBlock: { (error, snapshot) in
            
            completion(error, snapshot)
        })
    }
    
    //MARK:-- Insert Message
    static func insertMessage(parent:String, message: Message ,completion: @escaping (Error?, DatabaseReference) -> ())  {
        let key = DataService.data_service.FIREBASE_BASE_REF.child(FIREBASE_CONTSTANTS.messageRoot).child(parent).childByAutoId()
        key.setValue(message.toAnyObject(), withCompletionBlock: { (error, snapshot) in
            
            completion(error, snapshot)
        })
    }

 
}
