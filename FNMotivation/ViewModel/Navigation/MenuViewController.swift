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
    case authentication
}

class MenuViewController: UIViewController {
    
    var currentNavigationController: UINavigationController?
    let reuseIdentifier = "menuCell"
    let authNotificationName = Notification.Name(DefaultValues.authNotificationKey)
    let logoutNotificationName = Notification.Name(DefaultValues.logoutNotificationKey)
    let signUpNotificationName = Notification.Name(DefaultValues.signUpNotificationKey)
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBOutlet weak var userFullName: UILabel!
    @IBOutlet weak var userProfileImage: UIImageView!
    
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var menuTableView: UITableView!
    
    var menuOptions: [MenuOption] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeMenuView()
        handleAuthenticatedState()
        createObservers()
    }
    
    func createObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(MenuViewController.handleAuth(notification:)), name: authNotificationName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MenuViewController.handleAuth(notification:)), name: logoutNotificationName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MenuViewController.handleAuth(notification:)), name: signUpNotificationName, object: nil)
    }
    
    @objc
    func handleAuth(notification: NSNotification) {
        handleAuthenticatedState()
    }
    
    @objc
    private func logoutAction() {
        let alert = UIAlertController(title: "Are you sure?", message: "By logging out you will no longer have access to your saved searches or your user specific information from this device.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Log out", style: .destructive, handler: { (logout) in
            AuthenticationManager().logoutUser { (message) in
                let logoutNotificationName = Notification.Name(rawValue: DefaultValues.logoutNotificationKey)
                NotificationCenter.default.post(name: logoutNotificationName, object: nil)
            }
        }))
        if let baseViewController = self.parent as? BaseViewController {
            baseViewController.hideSideMenu()
            self.present(alert, animated: true, completion: nil)
        }
    }
    func handleAuthenticatedState() {
        if AuthenticationManager().currentSessionIsActive() {
            self.userProfileImage.image = UIImage(named: "avatar")
            // TODO: - Refactor
            self.userFullName.isHidden = false
            self.userFullName.text = defaultsHolder.value(forKey: DefaultValues.fullname) as? String
            
            menuOptions = [
                MenuOption(menuIcon: UIImage(named: "icn_about")!, menuTitle: "Home", key: .home),
                MenuOption(menuIcon: UIImage(named: "icn_about")!, menuTitle: "About FNM", key: .about),
                MenuOption(menuIcon: UIImage(named: "icn_about")!, menuTitle: "Contact", key: .contact),
                MenuOption(menuIcon: UIImage(named: "icn_about")!, menuTitle: "Visit Website", key: .other)
            ]
            self.logoutButton.isHidden = false
        } else {
            self.userProfileImage.image = #imageLiteral(resourceName: "avatar")
            self.userFullName.text = "Sign in"
            menuOptions = [
                MenuOption(menuIcon: UIImage(named: "icn_about")!, menuTitle: "Sign in/Create your account", key: .authentication),
                MenuOption(menuIcon: UIImage(named: "icn_about")!, menuTitle: "Home", key: .home),
                MenuOption(menuIcon: UIImage(named: "icn_about")!, menuTitle: "About FNM", key: .about),
                MenuOption(menuIcon: UIImage(named: "icn_about")!, menuTitle: "Contact", key: .contact),
                MenuOption(menuIcon: UIImage(named: "icn_about")!, menuTitle: "Visit Website", key: .other)
            ]
            self.logoutButton.isHidden = true
        }
        self.menuTableView.reloadData()
    }
    private func initializeMenuView() {
        logoutButton.addTarget(self, action: #selector(logoutAction), for: .touchUpInside)
        versionLabel.text = "Version: " + Bundle.main.fullVersion
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
        if let currentActiveNav = self.currentNavigationController, let baseViewController = self.parent as? BaseViewController {
            baseViewController.hideSideMenu()
            switch menuOptions[indexPath.row].key {
                case .authentication:
                    guard let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "authenticationViewController") as? AuthenticationViewController else { return }
                    if let baseViewController = self.parent as? BaseViewController {
                        baseViewController.hideSideMenu()
                        baseViewController.present(controller, animated: true, completion: nil)
                    }
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

extension MenuViewController: LoginViewDelegate {
    func loginSuccessful() {
        
    }
}

extension MenuViewController: SignupViewDelegate {
    func signupSuccessful() {
        
    }
}
