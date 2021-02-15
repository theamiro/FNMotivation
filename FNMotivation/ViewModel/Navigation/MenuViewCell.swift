//
//  MenuCellView.swift
//  FNMotivation
//
//  Created by Michael Amiro on 20/07/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit

class MenuViewCell: UITableViewCell {
    @IBOutlet weak var menuIcon: UIImageView!
    @IBOutlet weak var menuTitle: UILabel!
    
    func configure(using data: MenuOption) {
        self.menuIcon.image = data.icon
        self.menuTitle.text = data.title
    }
}
