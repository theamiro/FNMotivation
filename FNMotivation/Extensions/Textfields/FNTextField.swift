//
//  FNTextFields.swift
//  FNMotivation
//
//  Created by Michael Amiro on 14/07/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit

@IBDesignable
class FNTextField: UITextField {
    // MARK: - Properties
    @IBInspectable
    var defaultIcon: UIImage? {
        didSet {
            setIcon()
        }
    }
    
    @IBInspectable
    var focusIcon: UIImage? {
        didSet {
            setIcon()
        }
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setIcon()
        initializeTextField()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setIcon()
        initializeTextField()
    }
    
    func setIcon() {
        if defaultIcon != nil {
            // We have to enable leftViewMode so that we can embed image here
            leftViewMode = .always
            
            leftView?.isHidden = false
            leftView = setDefaultView()
        } else {
            leftView = nil
        }
    }
    func setDefaultView() -> UIView {
        // Creating an imageView as Image container
        let leftImageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
        leftImageView.image = defaultIcon
        
        let view = UIView(frame: CGRect(x:0, y:0, width: 28, height: 20))
        view.addSubview(leftImageView)
        
        return view
    }
    
    func setFocusView() -> UIView {
        // Creating an imageView as Image container
        let leftImageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
        leftImageView.image = focusIcon
        
        let view = UIView(frame: CGRect(x:0, y:0, width: 28, height: 20))
        view.addSubview(leftImageView)
        
        return view
    }
    
    func initializeTextField() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(named: "LightGray")?.cgColor
        self.layer.cornerRadius = 5
    }
}
extension FNTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        leftView = nil
        if focusIcon != nil {
            // We have to enable leftViewMode so that we can embed image here
            leftViewMode = .always
            
            leftView?.isHidden = false
            leftView = setFocusView()
        } else {
            leftView = nil
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        leftView = nil
        setIcon()
    }
}
extension FNTextField {
    func validatedText(validationType: ValidatorType) throws -> String {
        let validator = VaildatorFactory.validatorFor(type: validationType)
        return try validator.validated(self.text!)
    }
}
