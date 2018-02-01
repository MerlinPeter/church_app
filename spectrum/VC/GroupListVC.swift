//
//  EventListVC.swift
//  spectrum
//
//  Created by Merlin Ahila on 12/2/17.
//  Copyright © 2017 Merlin Ahila. All rights reserved.
//

import UIKit
import FirebaseDatabaseUI
import Chatto
import ChattoAdditions


class GroupListVC: BaseVC  {
    
    var dataSource: FUITableViewDataSource?
    var churchKey :String = APP_CONTSTANTS.parent
 
    @IBOutlet weak var tableView: UITableView!
     
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
    tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
    tableView.separatorColor = UIColor.darkGray
  
        let query = DataService.data_service.FIREBASE_BASE_REF.child(FIREBASE_CONTSTANTS.groupRoot).child(churchKey).queryOrderedByKey()
        
        dataSource = PostDataSource.init(query: query , populateCell: { (tableView: UITableView, indexPath: IndexPath, snap: DataSnapshot) -> UITableViewCell in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupCell
            
            guard (snap.value as? NSDictionary) != nil else { return cell }
            if let group = Group(snapshot: snap){
                cell.groupName.text = group.title
                cell.groupDetail.text = group.groupDescription
                 
            }
            //self.setCellBackGround(cell:cell)
            cell.backgroundColor = UIColor.bma_color(rgb: 0xF1B77A)

             return cell
 
        })
        dataSource?.bind(to: tableView)
        tableView.tableFooterView = UIView()
    }
    
}

extension GroupListVC : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
        performSegue(withIdentifier: "MessageSegue", sender: dataSource?.snapshot(at: indexPath.row))
    }
    
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return(75)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard sender != nil else {
            return
        }
        
        if  let destinationVC = segue.destination as? MessageListVC ,
            let groupSnap = sender as? DataSnapshot{
             destinationVC.group = Group(snapshot: groupSnap)
         }
        if  let destinationVC = segue.destination as? ChatViewController ,
            let groupSnap = sender as? DataSnapshot{
            
            
            let selectedGroup = Group(snapshot: groupSnap)
            let reference = DataService.data_service.FIREBASE_BASE_REF.child(FIREBASE_CONTSTANTS.messageRoot).child(APP_CONTSTANTS.parent).queryOrdered(byChild: "group").queryEqual(toValue: selectedGroup?.key )
            reference.observeSingleEvent(of: .value, with: { [ weak self ] (snapshot)  in
                var messageArray = [Message]()
                
                for rest in snapshot.children.allObjects as! [DataSnapshot] {
                    messageArray.append(Message(snapshot: rest )!)
 
                let converted = self?.convertToChatItemProtocol(messages: messageArray)
                
                destinationVC.dataSource = ChatDataSource(initialMessages: converted!, uid: (selectedGroup?.key)!)
            }
             })
         }
        if  let destinationVC = segue.destination as? MessageVC ,
            let groupSnap = sender as? DataSnapshot{
            let group = Group(snapshot: groupSnap)
            destinationVC.groupName = group?.title
            destinationVC.groupKey = group?.key
            
        }
    }
    
    
    func convertToChatItemProtocol(messages: [Message]) -> [ChatItemProtocol] {
        var convertedMessages = [ChatItemProtocol]()
        
        convertedMessages = messages.map({ (message) -> ChatItemProtocol in
            let senderId = message.author
            let type = "text" //message.type
            
            let model = MessageModel(
                uid: message.uid,
                senderId: senderId,
                type: type,
                isIncoming: senderId == Me.uid ? false : true,
                date: Date(timeIntervalSinceReferenceDate: Double(message.date)),
                status: MessageStatus.success             )
            
                 let textMessage = TextModel(messageModel: model, text: message.message)
                return textMessage
            
        })
      
        
        return convertedMessages
    }
}



 
