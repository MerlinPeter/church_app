//
//  NameModel.swift
//  spectrum
//
//  Created by Peter Joseph Karunanidhi on 1/22/18.
//  Copyright © 2018 Merlin Ahila. All rights reserved.
//

import Foundation
 import UIKit
import Chatto

class NameModel: ChatItemProtocol {
    
    var type: ChatItemType = NameModel.chatItemType
    var uid: String
    let name: String
    
    static var chatItemType: ChatItemType {
        return "NameModel"
    }
    
    init(name: String, uid: String) {
        self.name = name
        self.uid = uid
    }
}
