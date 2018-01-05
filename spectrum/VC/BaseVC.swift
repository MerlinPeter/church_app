//
//  BaseVC.swift
//  spectrum
//
//  Created by Merlin Ahila on 12/9/17.
//  Copyright © 2017 Merlin Ahila. All rights reserved.
//

import UIKit
class BaseVC: UIViewController {
    
    

    
    func alert(title:String = "Spectrum",message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

