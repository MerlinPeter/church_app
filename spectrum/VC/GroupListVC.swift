//
//  EventListVC.swift
//  spectrum
//
//  Created by Merlin Ahila on 12/2/17.
//  Copyright © 2017 Merlin Ahila. All rights reserved.
//

import UIKit
import FirebaseDatabaseUI


class GroupListVC: BaseVC  {
    
    var dataSource: FUITableViewDataSource?
    var churchKey :String = APP_CONTSTANTS.parent
 
    @IBOutlet weak var tableView: UITableView!
     
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let query = DataService.data_service.FIREBASE_BASE_REF.child(FIREBASE_CONTSTANTS.groupRoot).child(churchKey).queryOrderedByKey()
        
        dataSource = PostDataSource.init(query: query , populateCell: { (tableView: UITableView, indexPath: IndexPath, snap: DataSnapshot) -> UITableViewCell in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath)
            
            guard (snap.value as? NSDictionary) != nil else { return cell }
            if let group = Group(snapshot: snap){
                cell.textLabel?.text = group.title
                cell.detailTextLabel?.text = group.groupDescription
                 
            }
            return cell
        })
        dataSource?.bind(to: tableView)
    }
    
 }

extension GroupListVC : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
        performSegue(withIdentifier: "MessageSegue", sender: dataSource?.snapshot(at: indexPath.row))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard sender != nil else {
            return
        }
        
        if  let destinationVC = segue.destination as? MessageListVC ,
            let groupSnap = sender as? DataSnapshot{
             destinationVC.group = Group(snapshot: groupSnap)
         }
        if  let destinationVC = segue.destination as? MessageVC ,
            let groupSnap = sender as? DataSnapshot{
            let group = Group(snapshot: groupSnap)
            destinationVC.groupName = group?.title
            destinationVC.groupKey = group?.key
            
        }
    }
}



 
