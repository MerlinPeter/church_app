//
//  NameCollectionViewCell.swift
//  spectrum
//
//  Created by Peter Joseph Karunanidhi on 1/22/18.
//  Copyright © 2018 Merlin Ahila. All rights reserved.
//

import Foundation
import UIKit
import Chatto

class NameCollectionViewCell: UICollectionViewCell {
    
    private let label: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        self.label.font = UIFont(name: "Futura-Bold", size: 14)
        self.label.textAlignment = .right
        self.label.textColor = UIColor.brown
        self.contentView.addSubview(label)
    }
    
    var text: String = "" {
        didSet {
            if oldValue != text {
                self.setTextOnLabel(text)
            }
        }
    }
    
    private func setTextOnLabel(_ text: String) {
        self.label.text = text
        self.setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.label.bounds = CGRect(x: 0, y: 0, width: contentView.bounds.width - 20, height: contentView.bounds.height)
        self.label.center = self.contentView.center
    }
}
