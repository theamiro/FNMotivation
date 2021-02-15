//
//  FNTabViewController.swift
//  FNMotivation
//
//  Created by Michael Amiro on 19/08/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit

class FNTabBarViewController:  UITabBarController, UITabBarControllerDelegate {
    
    var homeViewController: UINavigationController!
    var communityViewController: UINavigationController!
    var addStoryViewController: AddStoryViewController!
    var notificationsViewController: UINavigationController!
    var accountViewController: UINavigationController!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.delegate = self
        
        homeViewController = Storyboards.homeStoryboard.instantiateViewController(identifier: "homeNavigationViewController")
        communityViewController = Storyboards.communitiesStoryboard.instantiateViewController(identifier: "communityNavigationViewController")
        addStoryViewController = AddStoryViewController()
        notificationsViewController = Storyboards.notificationsStoryboard.instantiateViewController(identifier: "notificationsNavigationViewController")
        accountViewController = Storyboards.accountStoryboard.instantiateViewController(identifier: "profileNavigationViewController")
        
        homeViewController.tabBarItem.image = UIImage(named: "icn_home")
        homeViewController.tabBarItem.selectedImage = UIImage(named: "icn_home_active")
        
        communityViewController.tabBarItem.image = UIImage(named: "icn_community")
        communityViewController.tabBarItem.selectedImage = UIImage(named: "icn_community_active")
        
        addStoryViewController.tabBarItem.image = UIImage(named: "icn_plus")
        addStoryViewController.tabBarItem.selectedImage = UIImage(named: "icn_plus")
        
        notificationsViewController.tabBarItem.image = UIImage(named: "icn_notification")
        notificationsViewController.tabBarItem.selectedImage = UIImage(named: "icn_notification_active")
        
        accountViewController.tabBarItem.image = UIImage(named: "icn_user")
        accountViewController.tabBarItem.selectedImage = UIImage(named: "icn_user_active")
        
        viewControllers = [homeViewController, communityViewController, addStoryViewController, notificationsViewController, accountViewController]
        
        for tabBarItem in tabBar.items! {
            tabBarItem.title = ""
//            tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
    }
    
    //MARK: UITabbar Delegate
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.isKind(of: AddStoryViewController.self) {
            if AuthenticationManager().currentSessionIsActive() {
                var viewController: UIViewController?
                
                let selector = UIAlertController(title: "", message: "Select type of post to add", preferredStyle: .actionSheet)
                let articleAction = UIAlertAction(title: "Article", style: .default) { (action) in
                    viewController = Storyboards.articlesStoryboard.instantiateViewController(identifier: "addArticleNavigationViewController")
                    viewController?.modalPresentationStyle = .overFullScreen
                    self.present(viewController!, animated: true, completion: nil)
                }
                let storyAction = UIAlertAction(title: "Story", style: .default) { (action) in
                    viewController = Storyboards.storiesStoryboard.instantiateViewController(identifier: "addStoryNavigationViewController")
                    viewController?.modalPresentationStyle = .overFullScreen
                    self.present(viewController!, animated: true, completion: nil)
                }
                selector.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                }))
                
                selector.addAction(articleAction)
                selector.addAction(storyAction)
                self.present(selector, animated: true, completion: nil)
            } else {
                let vc = Storyboards.authStoryboard.instantiateViewController(identifier: "authenticationViewController")
                vc.modalPresentationStyle = .formSheet
                self.present(vc, animated: true, completion: nil)
            }
            return false
        }
        return true
    }
    
}
