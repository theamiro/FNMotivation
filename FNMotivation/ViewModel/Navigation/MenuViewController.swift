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
    
    init(menuIcon: UIImage, menuTitle: String) {
        self.menuIcon = menuIcon
        self.menuTitle = menuTitle
    }
}

class MenuViewController: UIViewController {
    let reuseIdentifier = "menuCell"
    
    @IBOutlet weak var versionLabel: UILabel!
    
    var menuOptions: [MenuOption] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        versionLabel.text = "Version: " + Bundle.main.fullVersion
        
        menuOptions.append(MenuOption(menuIcon: UIImage(named: "icn_about")!, menuTitle: "About FNM"))
        menuOptions.append(MenuOption(menuIcon: UIImage(named: "icn_about")!, menuTitle: "Contact"))
        menuOptions.append(MenuOption(menuIcon: UIImage(named: "icn_about")!, menuTitle: "Visit Website"))
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
}
