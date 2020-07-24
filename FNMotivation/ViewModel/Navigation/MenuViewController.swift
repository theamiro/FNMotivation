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
    case about
    case contact
    case other
}

class MenuViewController: UIViewController {
    
    var currentActiveNavigation: UINavigationController?
    
    let reuseIdentifier = "menuCell"
    
    @IBOutlet weak var versionLabel: UILabel!
    
    var menuOptions: [MenuOption] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        versionLabel.text = "Version: " + Bundle.main.fullVersion
        
        menuOptions.append(MenuOption(menuIcon: UIImage(named: "icn_about")!, menuTitle: "About FNM", key: .about))
        menuOptions.append(MenuOption(menuIcon: UIImage(named: "icn_about")!, menuTitle: "Contact", key: .contact))
        menuOptions.append(MenuOption(menuIcon: UIImage(named: "icn_about")!, menuTitle: "Visit Website", key: .other))
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
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}
