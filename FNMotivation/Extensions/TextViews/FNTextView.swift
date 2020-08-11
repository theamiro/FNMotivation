//
//  FNTextView.swift
//  FNMotivation
//
//  Created by Michael Amiro on 10/08/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit

class FNTextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        initializeTextView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
        initializeTextView()
    }
    
    private func initializeTextView() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(named: "LightGray")?.cgColor
        self.layer.cornerRadius = 5
        self.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        
        let textViewToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        textViewToolbar.barStyle = .default
        textViewToolbar.items = [
            UIBarButtonItem(image: UIImage(named: "icn_bold"), style: .plain, target: self, action: #selector(makeTextBold)),
            UIBarButtonItem(image: UIImage(named: "icn_italic"), style: .plain, target: self, action: nil),
            UIBarButtonItem(image: UIImage(named: "icn_underline"), style: .plain, target: self, action: nil),
            UIBarButtonItem(image: UIImage(named: "icn_unorder_list"), style: .plain, target: self, action: nil),
            UIBarButtonItem(image: UIImage(named: "icn_link"), style: .plain, target: self, action: nil),
            UIBarButtonItem(image: UIImage(named: "icn_media"), style: .plain, target: self, action: nil),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        ]
        textViewToolbar.sizeToFit()
        
        
        self.inputAccessoryView = textViewToolbar
    }
    
    @objc func makeTextBold() {
        //Cancel with number pad
        print(self.selectedRange)
    }
    @objc func doneWithNumberPad() {
        //Done with number pad
    }
}
