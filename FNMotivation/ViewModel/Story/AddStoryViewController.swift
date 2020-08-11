//
//  AddStory.swift
//  FNMotivation
//
//  Created by Michael Amiro on 10/08/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit
import RichEditorView

class AddStoryViewController: UIViewController {
    
    @IBOutlet weak var storyTitle: FNTextField!
    @IBOutlet weak var storyTags: FNTextField!
    @IBOutlet weak var editor: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeEditor()
    }
    
    private func initializeEditor() {
        
    }
}
