//
//  CheckBox.swift
//  FNMotivation
//
//  Created by Michael Amiro on 14/07/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit

@IBDesignable
class FNCheckBox: UIButton {
    // MARK: - Properties
    @IBInspectable
    var uncheckedImage: UIImage? {
        didSet {
            setupViews()
        }
    }
    @IBInspectable
    var checkedImage: UIImage? {
        didSet {
            setupViews()
        }
    }
    private var feedbackGenerator: UIImpactFeedbackGenerator?
    //  MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    func setupViews() {
        self.titleEdgeInsets.left = 5.0
        self.setImage(uncheckedImage, for: .normal)
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.feedbackGenerator = UIImpactFeedbackGenerator.init(style: .light)
        self.feedbackGenerator?.prepare()
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.isSelected = !isSelected
        
        if isSelected {
            self.setImage(checkedImage, for: .selected)
        } else {
            self.setImage(uncheckedImage, for: .normal)
        }
        self.sendActions(for: .valueChanged)
        
        self.feedbackGenerator?.impactOccurred()
        self.feedbackGenerator = nil
    }
}
