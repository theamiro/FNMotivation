//
//  AlertsController.swift
//  FNMotivation
//
//  Created by Michael Amiro on 24/07/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit
import SCLAlertView

class AlertsController {
    let alertNoButtonStyle = SCLAlertView.SCLAppearance(
        kWindowWidth: 300.0,
        kTitleFont: UIFont(name: "Futura", size: 22)!,
        kTextFont: UIFont(name: "Futura", size: 14)!,
        kButtonFont: UIFont(name: "Futura", size: 16)!,
        showCloseButton: false,
        showCircularIcon: false,
        contentViewCornerRadius : 10.0,
        fieldCornerRadius: 4.0,
        buttonCornerRadius: 4.0
    )
    
    func generateAlert(withError errorMessage: String) {
        let alert = SCLAlertView(appearance: self.alertNoButtonStyle)
        alert.addButton("dismiss", backgroundColor: UIColor.red, textColor: .white, showTimeout: nil) {}
        alert.showError("There's a problem", subTitle: errorMessage, closeButtonTitle: nil, timeout: nil, colorStyle: 0x050F50, colorTextButton: 0xFFFFFF, circleIconImage: nil, animationStyle: .noAnimation)
    }
    
    func generateAlert(withSuccess successMessage: String, andTitle titleMessage: String = "Success"){
        let alert = SCLAlertView(appearance: self.alertNoButtonStyle)
        alert.addButton("dismiss", backgroundColor: UIColor(named: "DarkBlue"), textColor: .white, showTimeout: nil) {}
        alert.showError(titleMessage, subTitle: successMessage, closeButtonTitle: nil, timeout: nil, colorStyle: 0x050F50, colorTextButton: 0xFFFFFF, circleIconImage: nil, animationStyle: .noAnimation)
    }
    
    
}
