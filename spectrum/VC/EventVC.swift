//
//  EventVC.swift
//  spectrum
//
//  Created by Merlin Ahila on 12/3/17.
//  Copyright © 2017 Merlin Ahila. All rights reserved.
//

import UIKit

class EventVC: BaseVC {
    
    @IBOutlet weak var eventImage: UIImageView!
    
    @IBOutlet weak var location: UITextField!
    
    @IBOutlet weak var eventTitle: UITextField!
    
    @IBOutlet weak var eventDate: UIDatePicker!
    
    @IBOutlet weak var eventDiscrption: UITextView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        
    }
    
    
    
    @IBAction func eventSave(_ sender: UIBarButtonItem) {
        
        if let location = location.text,!location.isEmpty,
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
        
        
    }

}
 
