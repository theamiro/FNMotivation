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
    
    func postComment(indexPath: IndexPath?)
    
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
    
    var selectedAtIndex: IndexPath?

    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(using data: Story) {
        titleLabel.text = data.title
        categoryLabel.text = data.communityTitle.capitalizingFirstLetter()
        authorLabel.text = "By \(data.username)"
        excerptLabel.text = data.body
        commentsButton.addTarget(self, action: #selector(postComment), for: .touchUpInside)
    }
    
    @IBAction func followAuthor(_ sender: Any) {
        delegate?.followAuthor(cell: self)
        followState = !followState
        configureFollowButton()
    }
    
    @IBAction func shareStory(_ sender: Any) {
        delegate?.shareStory(cell: self)
    }
    
    @objc
    func postComment() {
        if AuthenticationManager().currentSessionIsActive() {
            delegate?.postComment(indexPath: selectedAtIndex)
        } else {
            let authenticationViewController = UIStoryboard(name: "Main", bundle:
                Bundle.main).instantiateViewController(withIdentifier:
                    "authenticationViewController") as! AuthenticationViewController
            authenticationViewController.modalPresentationStyle = .formSheet
            self.parentContainerViewController()!.present(authenticationViewController, animated: true, completion: nil)
        }
    }
    @IBAction func likeStory(_ sender: Any) {
        if AuthenticationManager().currentSessionIsActive() {
            delegate?.likeStory(indexPath: selectedAtIndex)
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.25) {
                    self.likesButton.tintColor = .systemRed
                } completion: { (done) in
                    if done{
                        let feedback = UIImpactFeedbackGenerator()
                        feedback.impactOccurred()
                    }
                }
            }
        } else {
            let authenticationViewController = UIStoryboard(name: "Main", bundle:
                Bundle.main).instantiateViewController(withIdentifier:
                    "authenticationViewController") as! AuthenticationViewController
            authenticationViewController.modalPresentationStyle = .formSheet
            self.parentContainerViewController()!.present(authenticationViewController, animated: true, completion: nil)
        }
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
