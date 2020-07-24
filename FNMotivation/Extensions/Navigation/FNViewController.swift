//
//  FNViewController.swift
//  FNMotivation
//
//  Created by Michael Amiro on 20/07/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit

class FNViewController: UIViewController {

    let menuButton = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
    }
    
    func configureNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        menuButton.setImage(UIImage(named: "icn_menu"), for: .normal)
        menuButton.addTarget(self, action: #selector(menuTapped), for: .touchUpInside)
        
        let hamburgerMenu = UIBarButtonItem(customView: menuButton)
        
        let title = UIBarButtonItem(title: navigationItem.title, style: .plain, target: nil, action: nil)
        title.tintColor = .label
        title.setTitleTextAttributes([.font: UIFont(name: "Futura-Medium", size: 20)!], for: .normal)
        title.setTitleTextAttributes([.font: UIFont(name: "Futura-Medium", size: 20)!], for: .highlighted)
        
        let width = view.frame.width
        
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 60.0))
        titleView.backgroundColor = .clear
        
        let searchButton = UIButton(frame: CGRect(x: 0, y: 0, width: 36.0, height: 36.0))
        searchButton.setImage(UIImage(named: "icn_search"), for: .normal)
        searchButton.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchButton)
        
        navigationItem.setLeftBarButtonItems([hamburgerMenu, title], animated: true)
        
        self.navigationItem.titleView = titleView
    }
    
    @objc func menuTapped() {
        if let baseViewController = self.navigationController?.tabBarController?.parent as? BaseViewController {
            baseViewController.toggleSideMenu(fromViewController: self)
        }
    }
    
    @objc func searchTapped() {
        
    }
}
extension FNViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
//        guard let text = searchController.searchBar.text else { return }
//        print(text)
    }
}
