//
//  EventListVC.swift
//  spectrum
//
//  Created by Merlin Ahila on 12/2/17.
//  Copyright © 2017 Merlin Ahila. All rights reserved.
//

import UIKit
import FirebaseDatabaseUI


class EventListVC: BaseVC  {
    
    var dataSource: FUITableViewDataSource?
    var churchKey :String = APP_CONTSTANTS.parent
    var editRecord : Bool = false

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dsfsdf: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
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
    
    
}


