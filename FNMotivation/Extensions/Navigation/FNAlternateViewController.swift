//
//  FNAlternateViewController.swift
//  FNMotivation
//
//  Created by Michael Amiro on 19/08/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit

class FNAlternateViewController: UIViewController {
    
    let closeButton = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
    }
    
    func configureNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        closeButton.setImage(UIImage(named: "icn_back"), for: .normal)
        closeButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        let hamburgerMenu = UIBarButtonItem(customView: closeButton)
        
        let title = UIBarButtonItem(title: navigationItem.title, style: .plain, target: nil, action: nil)
        title.tintColor = .label
        title.setTitleTextAttributes([.font: UIFont(name: "Futura-Medium", size: 20)!], for: .normal)
        title.setTitleTextAttributes([.font: UIFont(name: "Futura-Medium", size: 20)!], for: .highlighted)
        
        let width = view.frame.width
        
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 60.0))
        titleView.backgroundColor = .clear
        
        navigationItem.setLeftBarButtonItems([hamburgerMenu, title], animated: true)
        
        self.navigationItem.titleView = titleView
    }
    
    @objc func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}

