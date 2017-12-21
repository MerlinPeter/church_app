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

class ChatViewController: BaseChatViewController {
    var dataSource: ChatDataSource!
    var decorator = Decorator()
    var messageArray: FUIArray!
    var userUID = String()

    
    var presenter: BasicChatInputBarPresenter!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        let senderId = Me.uid
        let model = MessageModel(
            uid: Me.uid,
            senderId: senderId,
            type: "text",
            isIncoming: senderId == Me.uid ? false : true,
            date: Date(timeIntervalSinceReferenceDate: 50505050.00),
            status:  MessageStatus.success          )
        
        let textMessage = TextModel(messageModel: model, text: "Hello World")
        let textMessage1 = TextModel(messageModel: model, text: "Hello World 2")
        
        if dataSource == nil {
            dataSource = ChatDataSource(initialMessages: [textMessage,textMessage1], uid: Me.uid)
        }
           self.dataSource.addMessage(message: textMessage)
        self.chatItemsDecorator = decorator
        self.chatDataSource = dataSource


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
          //  self?.sendOnlineTextMsg(text: text, uid: msgUID, double: double, senderId: senderID)
            
        }
        return item
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
        
        textMessageBuilder.baseMessageStyle = Avatar()
        photoMessageBuilder.baseCellStyle = Avatar()
        
        return [
            TextModel.chatItemType : [textMessageBuilder],
            PhotoModel.chatItemType: [photoMessageBuilder],
           // TimeSeparatorModel.chatItemType: [TimeSeparatorPresenterBuilder()],
           // SendingStatusModel.chatItemType: [SendingStatusPresenterBuilder()]
        ]
    }
}
