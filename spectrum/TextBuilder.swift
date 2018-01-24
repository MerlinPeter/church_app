//
//  TextBuilder.swift
//  ChattoChatApp
//
//  Created by Alif on 12/10/2017.
//  Copyright © 2017 Alif. All rights reserved.
//

import Foundation
import Chatto
import ChattoAdditions

class ViewModel: TextMessageViewModel<TextModel> {
    
    override init(textMessage: TextModel, messageViewModel: MessageViewModelProtocol) {
        super.init(textMessage: textMessage, messageViewModel: messageViewModel)
    }
}

class TextBuilder: ViewModelBuilderProtocol {
    
    let defualtBuilder = MessageViewModelDefaultBuilder()
    
    func canCreateViewModel(fromModel decoratedTextMessage: Any) -> Bool {
        
        return decoratedTextMessage is TextModel
    
    }
    
    func createViewModel(_ decoratedTextMessage: TextModel) -> ViewModel {
        
        let textMessageViewModel = ViewModel(textMessage: decoratedTextMessage, messageViewModel: defualtBuilder.createMessageViewModel(decoratedTextMessage))
           // textMessageViewModel.avatarImage.value = #imageLiteral(resourceName: "avatar")
        
        return textMessageViewModel
        
    }
    
}
