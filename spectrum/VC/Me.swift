//
//  Me.swift
//  spectrum
//
//  Created by Merlin Ahila on 12/17/17.
//  Copyright © 2017 Merlin Ahila. All rights reserved.
//

import Foundation
import FirebaseAuth

class Me {
    static var uid: String {
         return Auth.auth().currentUser!.uid
    }
}
