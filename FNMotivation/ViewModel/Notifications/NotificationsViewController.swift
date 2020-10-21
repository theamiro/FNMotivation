//
//  NotificationsViewController.swift
//  FNMotivation
//
//  Created by Michael Amiro on 20/07/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit

struct RemoteNotification {
    var profileImage: UIImage
    var message: String
    var time: String
    var read: Bool
    
    init(profileImage: UIImage, message: String, time: String, read: Bool) {
        self.profileImage = profileImage
        self.message = message
        self.time = time
        self.read = read
    }
}

class NotificationsViewController: FNViewController, UIActionSheetDelegate {
    
    var notifications: [RemoteNotification] = []
    @IBOutlet weak var tableView: UITableView!
    var reuseIdentifier = "notificationCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        TODO: Apply the required action - navigate to the specific view
        let refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        
        tableView.allowsSelection = false
        for i in 1...20 {
            notifications.append(RemoteNotification(profileImage: UIImage(named: "amiro-memoji")!, message: "Lorem ipsum dolor sit amet.", time: "\(i) mins ago", read: i % 2 == 0 ? true : false))
        }
    }
}

extension NotificationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! NotificationViewCell
        //        cell.profileImage = UIImageView(image: UIImage(named: "header_background"))
        cell.notificationMessage.text = notifications[indexPath.row].message
        cell.timeLabel.text = notifications[indexPath.row].time
        if notifications[indexPath.row].read == true {
            cell.statusIndicator.isHidden = true
        } else {
            cell.statusIndicator.isHidden = false
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.0
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteNotificationActionSheet = UIAlertController(title:" Delete Notification", message: "Are you sure?", preferredStyle: .actionSheet)
        deleteNotificationActionSheet.addAction(UIAlertAction(title:"Delete", style: .destructive, handler:{ [weak self] action in
            self?.notifications.remove(at: indexPath.row)
            self?.tableView.beginUpdates()
            self?.tableView.deleteRows(at: [indexPath], with: .fade)
            self?.tableView.endUpdates()
//            completion(true)
        }))
        
        deleteNotificationActionSheet.addAction(UIAlertAction(title:"Cancel", style: .cancel, handler:nil))
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] action, view, completion in
            self!.present(deleteNotificationActionSheet, animated:true, completion:nil)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        navigationController?.navigationBar.transform = .init(translationX: 0.0, y: min(0, -scrollView.contentOffset.y))
    }
    
}


