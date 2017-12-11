//
//  EventVC.swift
//  spectrum
//
//  Created by Merlin Ahila on 12/3/17.
//  Copyright © 2017 Merlin Ahila. All rights reserved.
//

import UIKit
import FirebaseAuth
class MessageVC: BaseVC {
    

    var author:String!
    
    @IBOutlet weak var message: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        
    }
    
    
    
    @IBAction func messageSave(_ sender: UIBarButtonItem) {
        
        if let message = message.text,!message.isEmpty,
            let author = Auth.auth().currentUser?.email
             {
             activityIndicator.startAnimating()
                
                let newMessage = Message(imageUrl: "", message: message, author: author, date: Int(Date().timeIntervalSince1970))
            
            DBHelper.insertMessage(parent: "Spectrum", message: newMessage,  completion: { error , snapshot  in
                
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                if (error == nil){
                    
                    self.alert(message: " Message Posted")
                }
                
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.message.text = ""
                 }
            })
        }else{
            
              self.alert(message: "Please fill all the date")
        }
      }
 }
