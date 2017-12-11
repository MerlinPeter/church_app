//
//  DataService.swift
//  spectrum
//
//  Created by Merlin Ahila on 12/8/17.
//  Copyright © 2017 Merlin Ahila. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class DataService {
    
    
    static let data_service = DataService();
    
    private var _FIREBASE_BASE_REF =  Database.database().reference()
    
    var FIREBASE_BASE_REF : DatabaseReference {
        return _FIREBASE_BASE_REF
    }
    
}

