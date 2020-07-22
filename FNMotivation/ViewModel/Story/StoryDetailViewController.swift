//
//  StoryDetailViewController.swift
//  FNMotivation
//
//  Created by Michael Amiro on 14/07/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit

struct Post {
    var title: String
    var meta: String
    var category: String
    var body: String
    var link: URL
    
    init(title: String, meta: String, category: String, body: String, link: String) {
        self.title = title
        self.meta = meta
        self.category = category
        self.body = body
        self.link = URL(string: link)!
    }
}

class StoryDetailViewController: UIViewController {

    var post: Post!
    
    @IBOutlet weak var postThumbnail: UIImageView!
    @IBOutlet weak var storyTitleLabel: UILabel!
    @IBOutlet weak var storyMetaLabel: UILabel!
    @IBOutlet weak var storyCategoryLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var storyBodyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextView()
        
        storyTitleLabel.text = post.title
        storyMetaLabel.text = post.meta
        storyCategoryLabel.text = post.category
        storyBodyTextView.text = post.body
    }
    
    @IBAction func shareStoryButton(_ sender: Any) {
        let message = "Hey! I found this article on Future Now Motivation. Check it out!"
        let url = post.link
        
        let activityViewController = UIActivityViewController(activityItems: [message, url], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.storyTitleLabel
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    fileprivate func configureTextView() {
        storyBodyTextView.textContainerInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
}
