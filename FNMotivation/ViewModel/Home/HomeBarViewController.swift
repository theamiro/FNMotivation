//
//  HomeViewController.swift
//  FNMotivation
//
//  Created by Michael Amiro on 20/09/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class HomeBarViewController: ButtonBarPagerTabStripViewController {
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let storiesViewController = Storyboards.storiesStoryboard.instantiateViewController(withIdentifier: "storiesViewController")
        let articlesViewController = Storyboards.articlesStoryboard.instantiateViewController(withIdentifier: "articlesViewController")
        
        return [storiesViewController, articlesViewController]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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
