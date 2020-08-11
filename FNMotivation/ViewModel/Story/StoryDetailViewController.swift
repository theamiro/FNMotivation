//
//  StoryDetailViewController.swift
//  FNMotivation
//
//  Created by Michael Amiro on 14/07/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit

class StoryDetailViewController: UIViewController {

    var post: Story!
    
    @IBOutlet weak var postThumbnail: UIImageView!
    @IBOutlet weak var storyTitleLabel: UILabel!
    @IBOutlet weak var storyMetaLabel: UILabel!
    @IBOutlet weak var storyCategoryLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var storyBodyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextView()
        initialize()
    }
    
    @IBAction func shareStoryButton(_ sender: Any) {
        let message = "Hey! I found this article on Future Now Motivation. Check it out!"
        let url = "https://wp.me"
        
        let activityViewController = UIActivityViewController(activityItems: [message, url], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.storyTitleLabel
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    func initialize() {
        postThumbnail.getImageFromURL(using: post.postThumbnail)
        storyTitleLabel.text = post.title
        storyMetaLabel.text = "\(post.userID)"
        storyCategoryLabel.text = post.communityCategories.capitalizingFirstLetter()
        storyBodyTextView.text = post.story
    }
    
    fileprivate func configureTextView() {
        storyBodyTextView.textContainerInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
}
