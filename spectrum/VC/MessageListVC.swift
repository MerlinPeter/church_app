//
//  EventListVC.swift
//  spectrum
//
//  Created by Merlin Ahila on 12/2/17.
//  Copyright © 2017 Merlin Ahila. All rights reserved.
//

import UIKit
import FirebaseDatabaseUI


class MessageListVC: BaseVC  {
    
    var dataSource: FUITableViewDataSource?
    var churchKey :String = "Spectrum"
 
    @IBOutlet weak var tableView: UITableView!
     
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let query = DataService.data_service.FIREBASE_BASE_REF.child(FIREBASE_CONTSTANTS.messageRoot).child(churchKey).queryOrderedByKey()
        
        dataSource = PostDataSource.init(query: query , populateCell: { (tableView: UITableView, indexPath: IndexPath, snap: DataSnapshot) -> UITableViewCell in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)
            
            guard (snap.value as? NSDictionary) != nil else { return cell }
            if let message = Message(snapshot: snap){
                cell.textLabel?.text = message.author
                cell.detailTextLabel?.text = message.message
                 
            }
            return cell
        })
        dataSource?.bind(to: tableView)
    }
    
  
    
    
}


class PostDataSource: FUITableViewDataSource {
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
        
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
         
         snapshot(at: indexPath.row).ref.removeValue()
         
         }
    }
    
}



