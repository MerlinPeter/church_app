//
//  SermonVC.swift
//  spectrum
//
//  Created by Merlin Ahila on 12/10/17.
//  Copyright © 2017 Merlin Ahila. All rights reserved.
//

import Foundation

import UIKit

class SermonVC: BaseVC {
    
     @IBOutlet weak var sermonView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string:"https://www.youtube.com/watch?v=tBsnuwFYR08&list=PLs1Rf1TEhIU7lc0P9UNKOPIqhWDkZvHm7"){
            sermonView.loadRequest(URLRequest(url:url))

        }
        
        
    }
}
