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
    var groupKey:String!
    var groupName:String!
    
    @IBOutlet var groupTitle: UILabel!
    @IBOutlet weak var message: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        
        groupTitle.text = "Posting in " + groupName 
        
     }
    
    
    
    @IBAction func messageSave(_ sender: UIBarButtonItem) {
        
        if  let message = message.text,!message.isEmpty,
            let author = Auth.auth().currentUser?.email,
            let groupKey = groupKey
             {
             activityIndicator.startAnimating()
                
                
                let newMessage = Message(imageUrl: "", message: message, author: author, date: Int(Date().timeIntervalSince1970), group: groupKey)
            
            DBHelper.insertMessage(parent: APP_CONTSTANTS.parent, message: newMessage,  completion: { error , snapshot  in
                
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                if (error == nil){
     
                 var vc = self.navigationController!.viewControllers
 
                    /* remove the search controller and new message */
                    vc.remove(at: 2)
                    vc.remove(at: 1)
                    /* push the message list*/
                    let MessageListVC = self.storyboard!.instantiateViewController(withIdentifier: "MessageListVC") as? ChatViewController
                    MessageListVC?.churchKey = APP_CONTSTANTS.parent
                    MessageListVC?.group = Group(imageUrl: "", title: self.groupName, eventDescription: "", date: 0, status: GROUP_STATUS.active, key: groupKey)
                    vc.insert(MessageListVC!, at: 1)
                    self.navigationController?.setViewControllers(vc, animated: true)

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
