//
//  SelectCommunityViewController.swift
//  FNMotivation
//
//  Created by Michael Amiro on 08/12/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit

protocol SelectCommunityDelegate {
    func didSelectCommunity(name: String, id: Int)
}

class SelectCommunityViewController: FNAlternateViewController {
    let reuseIdentifier = "communityCell"
    var communities: [Community] = []
    var delegate: SelectCommunityDelegate!
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkingService.shared.makeCall(fromUrl: NetworkingValues.apiUrl + "/communities", networkCallType: .get) { [weak self] (state, message, dataObject) in
            if state {
                guard let jsonResponse = dataObject as? [String: Any] else {
                    AlertsController().generateAlert(withError: ErrorMessage.parseError)
                    return
                }
                guard let communityData = jsonResponse["data"] as? [[String: Any]] else {
                    AlertsController().generateAlert(withError: "Not an Array of Communities")
                    return
                }
                for community in communityData {
                    guard let id = community["id"] as? Int,
                        let title = community["community_title"] as? String,
                        let image = community["image_url"] as? String else {
                            AlertsController().generateAlert(withError: "Failed to get community")
                            return
                    }
                    self!.communities.append(Community(id: id, title: title, imageURL: image))
                }
                
                self!.tableview.reloadData()
            } else {
                AlertsController().generateAlert(withError: "Error getting communities")
                self!.dismiss(animated: true, completion: nil)
            }
        }
    }
}
extension SelectCommunityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return communities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel!.text = communities[indexPath.row].title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.didSelectCommunity(name: communities[indexPath.row].title, id: communities[indexPath.row].id)
        performSegue(withIdentifier: "unwindToAddArticle", sender: self)
    }
    
}
