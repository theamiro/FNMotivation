//
//  HomeViewCell.swift
//  FNMotivation
//
//  Created by Michael Amiro on 13/06/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit

protocol HomeCollectionViewFunctionsDelegate {
    func followAuthor(cell: HomeViewCell)
    
    func shareStory(cell: HomeViewCell)
    
    func postComment(cell: HomeViewCell)
    
    func loveStory(cell: HomeViewCell)
}

class HomeViewCell: UICollectionViewCell {
    
    var delegate: HomeCollectionViewFunctionsDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var excerptLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var commentsButton: UIButton!
    @IBOutlet weak var likesButton: UIButton!
    
    @IBAction func followAuthor(_ sender: Any) {
        delegate?.followAuthor(cell: self)
    }
    
    @IBAction func shareStory(_ sender: Any) {
        delegate?.shareStory(cell: self)
    }
    @IBAction func postComment(_ sender: Any) {
    }
    @IBAction func loveStory(_ sender: Any) {
    }
}
