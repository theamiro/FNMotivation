//
//  CommentsViewController.swift
//  FNMotivation
//
//  Created by Michael Amiro on 21/07/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class CommentsViewController: UIViewController, IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Comments")
    }

    var reuseIdentifier = "commentCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
extension CommentsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
        cell?.detailTextLabel?.text = "This is a comment."
        return cell!
    }
}
