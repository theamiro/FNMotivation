//
//  HomeViewCell.swift
//  FNMotivation
//
//  Created by Michael Amiro on 13/06/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit

protocol StoryCollectionViewFunctionsDelegate {
    func followAuthor(cell: StoryCollectionViewCell)
    
    func shareStory(cell: StoryCollectionViewCell)
    
    func postComment(cell: StoryCollectionViewCell)
    
    func likeStory(indexPath: IndexPath?)
}

class StoryCollectionViewCell: UICollectionViewCell {
    
    var delegate: StoryCollectionViewFunctionsDelegate?
    lazy var followState: Bool = false
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var excerptLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var commentsButton: UIButton!
    @IBOutlet weak var likesButton: UIButton!

    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func followAuthor(_ sender: Any) {
        delegate?.followAuthor(cell: self)
        followState = !followState
        configureFollowButton()
    }
    
    @IBAction func shareStory(_ sender: Any) {
        delegate?.shareStory(cell: self)
    }
    @IBAction func postComment(_ sender: Any) {
    }
    @IBAction func likeStory(_ sender: Any) {
    }
    
    private func configureFollowButton() {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
        if self.followState{
            followButton.setTitle("Unfollow", for: .normal)
            followButton.backgroundColor = .clear
            followButton.layer.borderWidth = 1.5
            followButton.tintColor = UIColor(named: "Orange")
            followButton.setTitleColor(UIColor(named: "Orange"), for: .normal)
            followButton.layer.borderColor = UIColor(named: "Orange")?.cgColor
        } else {
            followButton.setTitle("Follow", for: .normal)
            followButton.setTitleColor(.white, for: .normal)
            followButton.backgroundColor = UIColor(named: "Orange")
            followButton.tintColor = .white
            followButton.layer.borderWidth = 0
        }
    }
}
