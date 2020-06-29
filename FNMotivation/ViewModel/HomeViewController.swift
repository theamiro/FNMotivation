//
//  HomeViewController.swift
//  FNMotivation
//
//  Created by Michael Amiro on 13/06/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    let reuseIdentifier = "homeCell"

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! HomeViewCell
        cell.titleLabel.text = "Dutch Coronavirus cases rise by 729 to 34,136"
        cell.categoryLabel.text = "Heart Disease"
        cell.authorLabel.text = "By Rigga on 14/04/2020"
        cell.excerptLabel.text = "Dutch Coronavirus cases rise by 729 to 34,136. Dutch Coronavirus cases rise by 729 to 34,136."
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 172.0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
}
