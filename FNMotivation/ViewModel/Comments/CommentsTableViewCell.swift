//
//  CommentsTableViewCell.swift
//  FNMotivation
//
//  Created by Michael Amiro on 08/01/2021.
//  Copyright © 2021 Michael Amiro. All rights reserved.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentBodyLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCells(using data: Comment){
        if data.avatar != nil {
            profileImage.getImageFromURL(using: data.avatar)
        } else {
            profileImage.image = UIImage(named: "placeholder")
        }
        nameLabel.text = data.fullname
        commentBodyLabel.text = data.message
        timeLabel.text = "2 hours ago"
//            data.createdAt
    }
}
