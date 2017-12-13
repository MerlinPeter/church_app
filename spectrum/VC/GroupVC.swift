//
//  EventVC.swift
//  spectrum
//
//  Created by Merlin Ahila on 12/3/17.
//  Copyright © 2017 Merlin Ahila. All rights reserved.
//

import UIKit

class GroupVC: BaseVC {
    
  
    
    @IBOutlet var groupTitle: UITextField!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var groupDiscription: UITextView!
    
    
    override func viewDidLoad() {
        
    }
    
    
    
    @IBAction func groupSave(_ sender: UIBarButtonItem) {
        
       /* if let location = location.text,!location.isEmpty,
            let eventTitle = eventTitle.text,!eventTitle.isEmpty,
            let eventDiscrption = eventDiscrption.text ,!eventDiscrption.isEmpty
            {
            let eventDate = self.eventDate.date
            activityIndicator.startAnimating()
                 let newEvent = Event(imageUrl: "", title: eventTitle, eventDescription: eventDiscrption, date: Int(eventDate.timeIntervalSince1970))
            
            DBHelper.insertEvent(parent: "Spectrum", event: newEvent,  completion: { error , snapshot  in
                
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                if (error == nil){
                    
                    self.alert(message: "New Event Saved")
                }
                
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.eventTitle.text = ""
                    self.eventDiscrption.text = ""
                }
            })
        }else{
            
              self.alert(message: "Please fill all the date")
        }
        
        
    }*/
    }

}

