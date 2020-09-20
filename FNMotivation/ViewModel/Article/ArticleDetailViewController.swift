//
//  ArticleDetailViewController.swift
//  FNMotivation
//
//  Created by Michael Amiro on 20/09/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit

class ArticleDetailViewController: UIViewController {

    @IBOutlet weak var postThumbnail: UIImageView!
    @IBOutlet weak var storyTitleLabel: UILabel!
    @IBOutlet weak var storyMetaLabel: UILabel!
    @IBOutlet weak var storyCategoryLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var articleBodyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
