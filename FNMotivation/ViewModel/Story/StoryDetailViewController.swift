//
//  StoryDetailViewController.swift
//  FNMotivation
//
//  Created by Michael Amiro on 14/07/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit

class StoryDetailViewController: UIViewController {

    @IBOutlet weak var storyTitleLabel: UILabel!
    @IBOutlet weak var storyMetaLabel: UILabel!
    @IBOutlet weak var storyCategoryLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var storyBodyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storyBodyTextView.textContainerInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        
    }
}
