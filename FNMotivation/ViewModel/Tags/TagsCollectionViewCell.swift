//
//  TagsCollectionViewCell.swift
//  FNMotivation
//
//  Created by Michael Amiro on 25/01/2021.
//  Copyright © 2021 Michael Amiro. All rights reserved.
//

import UIKit

class TagsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCells(using data: [String]){
        title.text = "#weight"
    }

}
