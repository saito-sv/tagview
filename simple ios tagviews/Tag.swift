//
//  Tag.swift
//  Marlon Monroy
//
//  Created by Marlon Monroy on 1/18/17.
//  Copyright © 2017 
//

import UIKit

class Tag: UIButton {

    var feedbackTagId:NSNumber?
    var feedbackTagTypeId:String?
    var feedbackTagName:String?

    
    func setSelectedState() {
        backgroundColor = UIColor.youplusBlue()
        setTitleColor(UIColor.white, for: .normal)
        layer.borderWidth = 0
    }
    
    func setDiselectedState() {
        backgroundColor = UIColor.clear
        layer.borderWidth = 1
        layer.borderColor = UIColor.youplusGrey().cgColor
        setTitleColor(UIColor.youplusGrey(), for: .normal)
    }
    
   
    convenience init() {
        self.init(frame: .zero)
        titleLabel?.font = UIFont.systemFont(ofSize: 15)
        contentEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




