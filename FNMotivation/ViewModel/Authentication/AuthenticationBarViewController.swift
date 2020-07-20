//
//  AuthenticationBarViewController.swift
//  FNMotivation
//
//  Created by Michael Amiro on 14/07/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class AuthenticationBarViewController: ButtonBarPagerTabStripViewController {
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginViewController")
        let registrationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "registrationViewController")
        
        return [loginViewController, registrationViewController]
    }
    
    override func viewDidLoad() {
        self.settings.style.selectedBarHeight = 4
        self.settings.style.buttonBarBackgroundColor = UIColor(named: "OffWhite")!
        self.settings.style.buttonBarItemBackgroundColor = UIColor(named: "OffWhite")!
        
        self.settings.style.selectedBarBackgroundColor = UIColor(named: "DarkBlue")!
        self.settings.style.buttonBarItemFont = UIFont(name: "Futura", size: 13.0)!
        
        self.settings.style.buttonBarItemTitleColor = UIColor(named: "DarkGray")!
        containerView.isScrollEnabled = false
        
        super.viewDidLoad()
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            
            oldCell?.label.textColor = UIColor(named: "MediumGray")
            newCell?.label.textColor = UIColor(named: "DarkBlue")
        }
    }
}
