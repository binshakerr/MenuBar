//
//  MenuCell.swift
//  MenuBar2
//
//  Created by Eslam Shaker  on 9/3/18.
//  Copyright © 2018 eslam shaker. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.alpha = 0.6
    }
    
    func setupCell(text: String) {
        titleLabel.text = text
    }
    
    override var isSelected: Bool {
        didSet{
            titleLabel.alpha = isSelected ? 1.0 : 0.6
        }
    }
    
}
