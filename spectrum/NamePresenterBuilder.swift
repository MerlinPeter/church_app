//
//  NamePresenterBuilder.swift
//  spectrum
//
//  Created by Peter Joseph Karunanidhi on 1/22/18.
//  Copyright © 2018 Merlin Ahila. All rights reserved.
//

import Foundation
import UIKit
import Chatto

public class NamePresenterBuilder: ChatItemPresenterBuilderProtocol {
    
    public func canHandleChatItem(_ chatItem: ChatItemProtocol) -> Bool {
        return chatItem is NameModel
    }
    
    public func createPresenterWithChatItem(_ chatItem: ChatItemProtocol) -> ChatItemPresenterProtocol {
        assert(self.canHandleChatItem(chatItem))
        return NamePresenter(nameModel: chatItem as! NameModel)
    }
    
    public var presenterType: ChatItemPresenterProtocol.Type {
        return NamePresenter.self
    }
}

class NamePresenter: ChatItemPresenterProtocol {
    
    let nameModel: NameModel
    init (nameModel: NameModel) {
        self.nameModel = nameModel
    }
    
    private static let cellReuseIdentifier = NameCollectionViewCell.self.description()
    
    static func registerCells(_ collectionView: UICollectionView) {
        collectionView.register(NameCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
    }
    
    func dequeueCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: NamePresenter.cellReuseIdentifier, for: indexPath)
    }
    
    func configureCell(_ cell: UICollectionViewCell, decorationAttributes: ChatItemDecorationAttributesProtocol?) {
        guard let nameCell = cell as? NameCollectionViewCell else {
            assert(false, "expecting status cell")
            return
        }
        nameCell.text = self.nameModel.name
    }
    
    var canCalculateHeightInBackground: Bool {
        return true
    }
    
    func heightForCell(maximumWidth width: CGFloat, decorationAttributes: ChatItemDecorationAttributesProtocol?) -> CGFloat {
        return 24
    }
}

