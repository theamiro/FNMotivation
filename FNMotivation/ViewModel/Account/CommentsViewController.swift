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
    
    var reuseIdentifier = "commentCell"
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "COMMENTS")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
extension CommentsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? CommentsViewCell
        cell?.commentLabel.text = "Lorem ipsum dolor sit amet sit dolor ipsum lorem."
        cell?.categoryLabel.text = "Anxiety"
        cell?.dateLabel.text = "21st January 2019"
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72.0
    }
}
