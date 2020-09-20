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
    var profileViewController: UINavigationController!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.delegate = self
        
        homeViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "homeNavigationViewController")
        communityViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "communityNavigationViewController")
        addStoryViewController = AddStoryViewController()
//            UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "addStoryNavigationViewController")
        
        notificationsViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "notificationsNavigationViewController")
        profileViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "profileNavigationViewController")
        
        homeViewController.tabBarItem.image = UIImage(named: "icn_home")
        homeViewController.tabBarItem.selectedImage = UIImage(named: "icn_home_active")
        
        communityViewController.tabBarItem.image = UIImage(named: "icn_community")
        communityViewController.tabBarItem.selectedImage = UIImage(named: "icn_community_active")
        
        addStoryViewController.tabBarItem.image = UIImage(named: "icn_plus")
        addStoryViewController.tabBarItem.selectedImage = UIImage(named: "icn_plus")
        
        notificationsViewController.tabBarItem.image = UIImage(named: "icn_notification")
        notificationsViewController.tabBarItem.selectedImage = UIImage(named: "icn_notification_active")
        
        profileViewController.tabBarItem.image = UIImage(named: "icn_user")
        profileViewController.tabBarItem.selectedImage = UIImage(named: "icn_user_active")
        
        viewControllers = [homeViewController, communityViewController, addStoryViewController, notificationsViewController, profileViewController]
        
        for tabBarItem in tabBar.items! {
            tabBarItem.title = ""
//            tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
    }
    
    //MARK: UITabbar Delegate
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.isKind(of: AddStoryViewController.self) {
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "addStoryNavigationViewController")
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
            return false
        }
        return true
    }
    
}
