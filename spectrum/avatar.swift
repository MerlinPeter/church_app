//
//  avatar.swift
//  Copyright © 2017 . All rights reserved.
//

import Foundation
import ChattoAdditions

class Avatar: BaseMessageCollectionViewCellDefaultStyle   {
 
    override func avatarSize(viewModel: MessageViewModelProtocol) -> CGSize {
        return CGSize(width: 30, height: 30)
    }
  
  }
class ChurchViewCellStyle : TextMessageCollectionViewCellDefaultStyle {
    
    init(){
        let colors = BaseMessageCollectionViewCellDefaultStyle.Colors(incoming: UIColor.bma_color(rgb: 0xF1B77A), outgoing: UIColor.bma_color(rgb: 0xF1B77A))
 
        let style = BaseMessageCollectionViewCellDefaultStyle(colors: colors)
         super.init(baseStyle: style)
        
    }
    
    override func textColor(viewModel: TextMessageViewModelProtocol, isSelected: Bool) -> UIColor {
        return UIColor.darkText
    }
    override func textFont(viewModel: TextMessageViewModelProtocol, isSelected: Bool) -> UIFont {
        return UIFont(name: "AvenirNext-Regular", size: 15)!
    }
    
}
