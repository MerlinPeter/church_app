//
//  TextHandler.swift

//

import Foundation
import Chatto
import ChattoAdditions
 
class TaxtHandler: BaseMessageInteractionHandlerProtocol {
    
    func userDidTapOnFailIcon(viewModel: ViewModel, failIconView: UIView) {
        print("TapOnFail")
    }
    
    func userDidTapOnAvatar(viewModel: ViewModel) {
        print("TapOnAvatar")
    }
    
    func userDidTapOnBubble(viewModel: ViewModel) {
        print("TapOnBubble")
    }
    
    func userDidBeginLongPressOnBubble(viewModel: ViewModel) {
        print("BeginLongPressOnBubble")
    }
    
    func userDidEndLongPressOnBubble(viewModel: ViewModel) {
        print("EndLongPressOnBubble")
    }
}
