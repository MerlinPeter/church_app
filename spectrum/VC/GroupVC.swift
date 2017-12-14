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
        super.viewDidLoad()
    }
    
    
    
    @IBAction func groupSave(_ sender: UIBarButtonItem) {
        
       if let groupTitle = groupTitle.text,!groupTitle.isEmpty,
            let groupDiscription = groupDiscription.text ,!groupDiscription.isEmpty
            {
            let createDate = Date().timeIntervalSince1970
            activityIndicator.startAnimating()
                 let newGroup = Group(imageUrl: "", title: groupTitle, eventDescription: groupDiscription, date: Int(createDate), status: GROUP_STATUS.active)
            
            DBHelper.insertGroup(parent: APP_CONTSTANTS.parent, group: newGroup,  completion: { error , snapshot  in
                
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                if (error == nil){
                    
                    self.alert(message: "New Group Created")
                }
                
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.groupTitle.text = ""
                    self.groupDiscription.text = ""
                }
            })
        }else{
            
              self.alert(message: "Please fill all the date")
        }
        
        
    }
    
}



