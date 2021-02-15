//
//  AddArticleViewController.swift
//  FNMotivation
//
//  Created by Michael Amiro on 20/09/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit

class AddArticleViewController: FNAlternateViewController {

    @IBOutlet weak var titleTextField: FNTextField!
    @IBOutlet weak var redirectLinkTextField: FNTextField!
    @IBOutlet weak var communityTextField: FNTextField!
    @IBOutlet weak var shareArticleButton: FNButton!
    
    var communityID: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func selectCommunitySelected(_ sender: Any) {
        guard let selectCommunityViewController = Storyboards.communitiesStoryboard.instantiateViewController(identifier: "selectCommunityViewController") as? SelectCommunityViewController else {
            return
        }
        selectCommunityViewController.delegate = self
        selectCommunityViewController.modalPresentationStyle = .automatic
        self.present(selectCommunityViewController, animated: true, completion: nil)
    }
    
    @IBAction func shareArticleButtonTapped(_ sender: Any) {
        shareArticleButton.setTitle("Sharing article...", for: .normal)
        guard let title = titleTextField.text else {
            AlertsController().generateAlert(withError: ErrorMessage.missingData)
            return
        }
        guard let redirectLink = redirectLinkTextField.text else {
            AlertsController().generateAlert(withError: ErrorMessage.missingData)
            return
        }
        guard let id = self.communityID else {
            AlertsController().generateAlert(withError: ErrorMessage.missingData)
            return
        }
        ArticleManager().publishArticle(title: title, redirectLink: redirectLink, communityID: id) { [weak self] (state, message) in
            if state {
                AlertsController().generateAlert(withSuccess: message, andTitle: "Success")
                self!.dismiss(animated: true, completion: nil)
            } else {
                AlertsController().generateAlert(withError: message)
                self!.shareArticleButton.setTitle("Share", for: .normal)
            }
        }
    }
}
extension AddArticleViewController: SelectCommunityDelegate {
    func didSelectCommunity(name: String, id: Int) {
        communityTextField.text = name
        communityTextField.resignFirstResponder()
        communityID = id
    }
}
extension AddArticleViewController {
    @IBAction func unwind( _ segue: UIStoryboardSegue) {
        
    }
}
