//
//  ProfileTabsViewController.swift
//  FNMotivation
//
//  Created by Michael Amiro on 21/07/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ProfileTabsViewController: ButtonBarPagerTabStripViewController {
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let profileViewController = Storyboards.accountStoryboard.instantiateViewController(withIdentifier: "profileViewController")
        let storyPostsViewController = Storyboards.accountStoryboard.instantiateViewController(withIdentifier: "storyPostsViewController")
        let commentsViewController = Storyboards.accountStoryboard.instantiateViewController(withIdentifier: "commentsViewController")
        
        return [profileViewController, storyPostsViewController, commentsViewController]
    }

    override func viewDidLoad() {
        self.settings.style.selectedBarHeight = 4
        self.settings.style.buttonBarBackgroundColor = UIColor(named: "BrilliantWhite")!
        self.settings.style.buttonBarItemBackgroundColor = UIColor(named: "BrilliantWhite")!
        
        self.settings.style.selectedBarBackgroundColor = UIColor(named: "DarkBlue")!
        self.settings.style.buttonBarItemFont = UIFont(name: "Futura Medium", size: 13.0)!
        
        self.settings.style.buttonBarItemTitleColor = UIColor(named: "DarkGray")!
        containerView.isScrollEnabled = false
        
        super.viewDidLoad()
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            
            oldCell?.label.textColor = UIColor(named: "MediumGray")
            newCell?.label.textColor = UIColor(named: "DarkBlue")
        }
        buttonBarView.layer.shadowColor = UIColor.black.cgColor
        buttonBarView.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        buttonBarView.layer.shadowOpacity = 0.2
        buttonBarView.layer.shadowRadius = 6
        buttonBarView.layer.masksToBounds =  false
        
    }
}
