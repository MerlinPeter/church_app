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
    var group: Group?
    var churchKey :String = APP_CONTSTANTS.parent
 
    @IBOutlet weak var tableView: UITableView!
     

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        guard let group =  group else {
            return
        }
        
        self.navigationItem.title = group.title

        let query = DataService.data_service.FIREBASE_BASE_REF.child(FIREBASE_CONTSTANTS.messageRoot).child(churchKey).queryOrdered(byChild: "group").queryEqual(toValue: group.key)
        
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
    


 @IBAction func composeAction(_ sender: Any) {

        performSegue(withIdentifier: "NewMessageSegue", sender:  group)
}
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard sender != nil else {
            return
        }
        
        if  let destinationVC = segue.destination as? MessageVC ,
            let group = sender as? Group{
            destinationVC.groupKey = group.key
            destinationVC.groupName = group.title
        }
    }
 }
/*extension MessageListVC : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "GroupMessage", sender: dataSource?.snapshot(at: indexPath.row).key)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard sender != nil else {
            return
        }
        
        if  let destinationVC = segue.destination as? MessageListVC ,
            let groupKey = sender as? String{
            destinationVC.group = groupKey
        }
    }
}*/



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



