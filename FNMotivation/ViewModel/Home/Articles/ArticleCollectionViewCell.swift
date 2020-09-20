//
//  ArticleCollectionViewCell.swift
//  FNMotivation
//
//  Created by Michael Amiro on 20/09/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit

protocol ArticleCollectionViewFunctionsDelegate {
    func followAuthor(cell: ArticleCollectionViewCell)
    
    func shareStory(cell: ArticleCollectionViewCell)
    
    func postComment(cell: ArticleCollectionViewCell)
    
    func loveStory(cell: ArticleCollectionViewCell)
}

class ArticleCollectionViewCell: UICollectionViewCell {
    
    var delegate: ArticleCollectionViewFunctionsDelegate?
    
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
