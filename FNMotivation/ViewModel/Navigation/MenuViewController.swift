//
//  MenuViewController.swift
//  FNMotivation
//
//  Created by Michael Amiro on 20/07/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit

struct MenuOption {
    var menuIcon: UIImage
    var menuTitle: String
    var key: MenuDataKeys
    
    init(menuIcon: UIImage, menuTitle: String, key: MenuDataKeys) {
        self.menuIcon = menuIcon
        self.menuTitle = menuTitle
        self.key = key
    }
}
enum MenuDataKeys {
    case home
    case about
    case contact
    case other
}

class MenuViewController: UIViewController {
    
    var currentNavigationController: UINavigationController?
    
    let reuseIdentifier = "menuCell"
    
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    var menuOptions: [MenuOption] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        versionLabel.text = "Version: " + Bundle.main.fullVersion
        menuOptions.append(MenuOption(menuIcon: UIImage(named: "icn_about")!, menuTitle: "Home", key: .home))
        menuOptions.append(MenuOption(menuIcon: UIImage(named: "icn_about")!, menuTitle: "About FNM", key: .about))
        menuOptions.append(MenuOption(menuIcon: UIImage(named: "icn_about")!, menuTitle: "Contact", key: .contact))
        menuOptions.append(MenuOption(menuIcon: UIImage(named: "icn_about")!, menuTitle: "Visit Website", key: .other))
        
        logoutButton.addTarget(self, action: #selector(logoutAction), for: .touchUpInside)
    }
    
    @objc
    private func logoutAction() {
        let alert = UIAlertController(title: "\(KeychainItem.currentUserIdentifier)", message: "Are you sure you want to log out of FN Motivation?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Log out", style: .destructive, handler: { (logout) in
            KeychainItem.deleteUserIdentifierFromKeychain()
            print("User Successsfully Logged out. Keychain Deleted")
        }))
        if let baseViewController = self.parent as? BaseViewController {
            baseViewController.hideSideMenu()
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! MenuViewCell
        //        cell.menuIcon = UIImageView(image: menuOptions[indexPath.row].menuIcon)
        cell.menuTitle.text = menuOptions[indexPath.row].menuTitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("selected")
        if let currentActiveNav = self.currentNavigationController, let baseViewController = self.parent as? BaseViewController {
            baseViewController.hideSideMenu()
            switch menuOptions[indexPath.row].key {
                case .home:
                    print("home")
                    currentActiveNav.popToRootViewController(animated: true)
                case .about:
                    print("about")
                    if let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "aboutViewController") as? AboutViewController {
                        currentActiveNav.pushViewController(controller, animated: true)
                    } else {
                        print("controllerFail")
                    }
                case .contact:
                    print("contact")
                    if let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "aboutViewController") as? AboutViewController {
                        currentActiveNav.pushViewController(controller, animated: true)
                    }
                case .other:
                    print("other")
                    if let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "aboutViewController") as? AboutViewController {
                        currentActiveNav.pushViewController(controller, animated: true)
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}
