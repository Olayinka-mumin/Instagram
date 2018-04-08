//
//  SignUpTabCell.swift
//  Instagram
//
//  Created by Olayinka Abdulmumin on 2/21/18.
//  Copyright © 2018 Olayinka Abdulmumin. All rights reserved.
//

import UIKit

class SignUpTabCell: UICollectionViewCell {
    
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    override var isHighlighted: Bool {
        didSet {
            cellLabel.textColor = isHighlighted ? UIColor.black : UIColor.gray;
            cellView.backgroundColor = isHighlighted ? UIColor.black : UIColor.init(red: 208, green: 208, blue: 208, alpha: 1);
        }
    }
    
    override var isSelected: Bool {
        didSet {
            cellLabel.textColor = isSelected ? UIColor.black : UIColor.gray;
            cellView.backgroundColor = isSelected ? UIColor.black : UIColor.init(red: 208, green: 208, blue: 208, alpha: 1);
        }
    }
}
