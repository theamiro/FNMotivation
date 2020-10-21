//
//  AddStory.swift
//  FNMotivation
//
//  Created by Michael Amiro on 10/08/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit
import DLRadioButton

class AddStoryViewController: FNAlternateViewController {
    
    @IBOutlet weak var articleRadioButton: DLRadioButton!
    @IBOutlet weak var storyRadioButton: DLRadioButton!
    @IBOutlet weak var storyTitle: FNTextField!
    @IBOutlet weak var storyTags: FNTextField!
    @IBOutlet weak var editor: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeEditor()
        initializeRadioButtons()
    }
    
    private func initializeEditor() {
        
    }
    private func initializeRadioButtons() {
        self.articleRadioButton.isSelected = true
    }
}
