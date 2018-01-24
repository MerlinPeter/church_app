//
//  EventListVC.swift
//  spectrum
//
//  Created by Merlin Ahila on 12/2/17.
//  Copyright © 2017 Merlin Ahila. All rights reserved.
//

import UIKit
import FirebaseDatabaseUI

import FirebaseAuth


class EventListVC: BaseVC  {
    
    var dataSource: FUITableViewDataSource?
    var churchKey :String = APP_CONTSTANTS.parent
    var editRecord : Bool = false

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dsfsdf: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine

        let query = DataService.data_service.FIREBASE_BASE_REF.child(FIREBASE_CONTSTANTS.eventRoot).child(churchKey).queryOrderedByKey()
        
        dataSource = PostDataSource.init(query: query , populateCell: { (tableView: UITableView, indexPath: IndexPath, snap: DataSnapshot) -> UITableViewCell in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)
            
            guard (snap.value as? NSDictionary) != nil else { return cell }
            
            if let event = Event(snapshot: snap){
                cell.textLabel?.text = event.title
                cell.detailTextLabel?.text = event.eventDescription
                 
            }
            return cell
        })
        dataSource?.bind(to: tableView)
    }
    
    @IBAction func signOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
}


