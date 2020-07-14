//
//  CustomUIButton.swift
//  FNMotivation
//
//  Created by Michael Amiro on 14/07/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit

class FNButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureButton()
    }
    
    func configureButton() {
//        setShadow()
            layer.cornerRadius = 10
    }
    
    func setShadow() {
        layer.cornerRadius = 10
        layer.shadowColor = UIColor(named: "DarkBlue")?.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        layer.shadowRadius = 9
        layer.shadowOpacity = 0.4
        clipsToBounds = true
        layer.masksToBounds = false
    }
}
