//
//  TagViewCell.swift
//  YouPlus
//
//  Created by Marlon Monroy on 1/17/17.
//  Copyright © 2017 
//

import UIKit

class TagViewCell: UICollectionViewCell {
    
    var itag = Tag() {
        didSet {
           backgroundView = itag
            setup()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
      setup()
    }
    
    func setup () {
     itag.layer.borderColor = UIColor.gray.cgColor
     itag.layer.borderWidth = 1
     itag.backgroundColor = UIColor.clear
     itag.setTitleColor(UIColor.gray, for: .normal)
     itag.layer.cornerRadius = itag.frame.size.height / 2
        
       
    }
    
    func setSelectedState() {
      itag.backgroundColor = UIColor.blue
      itag.setTitleColor(UIColor.white, for: .normal)
      itag.layer.borderWidth = 0
    }
    
    func setDiselectedState() {
        itag.backgroundColor = UIColor.clear
        itag.layer.borderWidth = 1
        itag.layer.borderColor = UIColor.gray.cgColor
        itag.setTitleColor(UIColor.gray, for: .normal)
    }
    
    
    
}
