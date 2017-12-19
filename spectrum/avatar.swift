//
//  avatar.swift
//  Copyright © 2017 Alif. All rights reserved.
//

import Foundation
import ChattoAdditions

class Avatar: BaseMessageCollectionViewCellDefaultStyle   {
    
    override func avatarSize(viewModel: MessageViewModelProtocol) -> CGSize {
        return CGSize(width: 30, height: 30)
    }
    
    // return viewModel.isIncoming ? CGSize(width: 30, height: 30) : CGSize.zero
}
