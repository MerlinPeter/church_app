//
//  BaseChatViewController.swift
//
//
//  Created by Merlin Ahila on 12/17/17.
//
//

import Chatto
import ChattoAdditions
import FirebaseDatabaseUI
import FirebaseAuth


class ChatViewController: BaseChatViewController {
    
    var dataSource: ChatDataSource!
    var decorator = Decorator()
    var group: Group?
    var churchKey :String = APP_CONTSTANTS.parent
    var messageArray : FUIArray!
    var userUID = String()
    var presenter: BasicChatInputBarPresenter!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.chatItemsDecorator = decorator
                       
        guard  let group = group  else {
            return
        }
        self.navigationItem.title = group.title
        
        
        messageArray =  FUIArray(
            query: DataService.data_service.FIREBASE_BASE_REF.child(FIREBASE_CONTSTANTS.messageRoot).child(APP_CONTSTANTS.parent).queryOrdered(byChild: "group").queryEqual(toValue: group.key )
            ,
            delegate: nil)
        
        self.messageArray.observeQuery()
        self.messageArray.delegate = self
        
    }
    
    @IBAction func composeAction(_ sender: Any) {
        
        guard  group != nil  else {
            return
        }
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
    var chatInputPresenter: BasicChatInputBarPresenter!
    
    override func createChatInputView() -> UIView {
        
        let chatInputView = ChatInputBar.loadNib()
        var appearance = ChatInputBarAppearance()
        appearance.sendButtonAppearance.title = NSLocalizedString("Send", comment: "")
        appearance.textInputAppearance.placeholderText = NSLocalizedString("Type a message", comment: "")
        self.presenter = BasicChatInputBarPresenter(chatInputBar: chatInputView, chatInputItems: self.createChatInputItems(), chatInputBarAppearance: appearance)
        chatInputView.maxCharactersCount = 1000
         return chatInputView
    }
    
    
    func createChatInputItems() -> [ChatInputItemProtocol] {
        var items = [ChatInputItemProtocol]()
        items.append(self.createTextInputItem())
        items.append(self.createPhotoInputItem())
        return items
    }
    
    private func createTextInputItem() -> TextChatInputItem {
        let item = TextChatInputItem()
        item.textInputHandler = { [weak self] text in
            let date = Date()
            let double = Double(date.timeIntervalSinceReferenceDate)
            let senderID = Me.uid
            let msgUID = ("\(double)" + senderID ).replacingOccurrences(of: ".", with: "")
            
            let message = MessageModel(
                uid: msgUID,
                senderId: senderID,
                type: TextModel.chatItemType,
                isIncoming: false,
                date: date,
                status: .sending
            )
            
            let textMessage = TextModel(messageModel: message, text: text)
            self?.dataSource.addMessage(message: textMessage)
            self?.sendOnlineTextMessage(text: text, uid: msgUID, double: double, senderId: senderID)
            
        }
        return item
    }
    
    func sendOnlineTextMessage(text: String, uid: String, double: Double, senderId: String) {
        
        let newMessage = Message(imageUrl: "", message: text, author: (Auth.auth().currentUser?.email)!, date: Int(double), group: (group?.key)!)
        
        DBHelper.insertMessage(parent: APP_CONTSTANTS.parent, message: newMessage,  completion: { error , snapshot  in
            
            if error != nil {
                
                self.dataSource.updateTextMessage(uid: uid, status: .failed)
                return
            }
            self.dataSource.updateTextMessage(uid: uid, status: .success)

        })
      }
    
    private func createPhotoInputItem() -> PhotosChatInputItem {
        let item = PhotosChatInputItem(presentingController: self)
        item.photoInputHandler = { [weak self] image in
            // Your handling logic
        }
        return item
    }
    
    override func createPresenterBuilders() -> [ChatItemType: [ChatItemPresenterBuilderProtocol]] {
        
        let textMessageBuilder = TextMessagePresenterBuilder(viewModelBuilder: TextBuilder(), interactionHandler: TaxtHandler())
         
        let photoMessageBuilder = PhotoMessagePresenterBuilder(viewModelBuilder: PhotoBuilder(), interactionHandler: PhotoHandler())
        
        textMessageBuilder.baseMessageStyle =  Avatar()
         
        textMessageBuilder.textCellStyle = ChurchViewCellStyle()
        
        photoMessageBuilder.baseCellStyle = Avatar()
        
        return [
            TextModel.chatItemType : [textMessageBuilder],
            PhotoModel.chatItemType: [photoMessageBuilder],
            NameModel.chatItemType: [NamePresenterBuilder()]
            // TimeSeparatorModel.chatItemType: [TimeSeparatorPresenterBuilder()],
            // SendingStatusModel.chatItemType: [SendingStatusPresenterBuilder()]
        ]
    }
}

extension ChatViewController : FUICollectionDelegate{
    func array(_ array: FUICollection, didAdd object: Any, at index: UInt) {
        
        let message = Message(snapshot: object as! DataSnapshot)
        let type =  "text"
        let uid = message?.key
        let contains = self.dataSource.controller.items.contains { (collectionViewMessage) -> Bool in
            return collectionViewMessage.uid == uid
        }
        
         if contains == false {
            let senderId =  Me.uid
            let model = MessageModel(
                uid: uid!,
                senderId: (message?.author)!,
                type: type,
                isIncoming: senderId == Me.uid ? false : true,
                date: Date(timeIntervalSinceReferenceDate: Double((message?.date)!)),
                status: MessageStatus.success
                
            )
            
            if type == TextModel.chatItemType {
                let textMessage = TextModel(messageModel: model, text: (message?.message)!)
                if self.dataSource == nil {
                    dataSource = ChatDataSource(initialMessages: [textMessage], uid: Me.uid)
                }else{
                    
                    self.dataSource.addMessage(message: textMessage)
                }
            }
         }
     }
    
    func arrayDidEndUpdates(_ collection: FUICollection) {
        self.chatDataSource = dataSource
        
    }
    
 }

