//
//  CustomTextField.swift
//  Deliverer
//
//  Created by Maaz TAGELDIN on 23/02/2023.
//

import UIKit

class CustomTextField: UITextField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.backgroundColor = UIColor(red: 0xFE/255, green: 0x72/255, blue: 0x4D/255, alpha: 1).cgColor
        layer.cornerRadius = 15
    }

}
