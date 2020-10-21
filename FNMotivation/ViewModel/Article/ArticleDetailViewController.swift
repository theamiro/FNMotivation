//
//  ArticleDetailViewController.swift
//  FNMotivation
//
//  Created by Michael Amiro on 20/09/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit

class ArticleDetailViewController: UIViewController {

    var article: Article!
    @IBOutlet weak var postThumbnail: UIImageView!
    @IBOutlet weak var storyTitleLabel: UILabel!
    @IBOutlet weak var storyMetaLabel: UILabel!
    @IBOutlet weak var storyCategoryLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var articleBodyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextView()
        storyTitleLabel.text = article.title
        storyMetaLabel.text = "By " + article.username.capitalizingFirstLetter()
        storyCategoryLabel.text = article.communityTitle.capitalizingFirstLetter()
        articleBodyTextView.text = article.redirectLink
    }
    
    fileprivate func configureTextView() {
        articleBodyTextView.textContainerInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
}
