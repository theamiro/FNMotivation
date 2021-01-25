//
//  StoryDetailViewController.swift
//  FNMotivation
//
//  Created by Michael Amiro on 14/07/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit
import Alamofire
import DZNEmptyDataSet

// MARK: - CommentsResponse
struct CommentsResponse: Decodable {
    let success: Bool
    let data: [Comment]
}

// MARK: - Comment
struct Comment: Decodable {
    let userID: Int
    let fullname: String?
    let username, email: String
    let avatar: String
    let commentID, storyID: Int
    let message, createdAt: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case fullname, username, email, avatar
        case commentID = "comment_id"
        case storyID = "story_id"
        case message, createdAt
    }
}



class StoryDetailViewController: UIViewController {

    var story: Story!
    var comments: [Comment] = []
    var tags: [String] = [
        "#wealth",
        "#wisdom",
        "#music",
        "#cleancode",
        "#covid-19",
        "#opportunity"
    ]
    
    var commentsIdentifier = "commentsIdentifier"
    
    @IBOutlet weak var postThumbnail: UIImageView!
    @IBOutlet weak var storyTitleLabel: UILabel!
    @IBOutlet weak var storyMetaLabel: UILabel!
    @IBOutlet weak var storyCategoryLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var storyBodyTextView: UITextView!
    @IBOutlet weak var commentsTable: SelfSizedTableView!
    @IBOutlet weak var commentToolbar: UIView!
    @IBOutlet weak var commentToolbarBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var tagsCollectionView: UICollectionView!
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextView()
        initialize()
        commentsTable.maxHeight = 900
//        textView.delegate = self
//        textView.isScrollEnabled = true
        makeCall()
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
//        textView.becomeFirstResponder()
    }
    @objc
    func handleKeyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            guard let keyboardAnimationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey]) as? Double else { return }
            guard let keyboardAnimationCurve = (userInfo[UIResponder.keyboardAnimationCurveUserInfoKey]) as? UInt else { return }
            
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            
            UIView.animateKeyframes(withDuration: keyboardAnimationDuration, delay: 0, options: UIView.KeyframeAnimationOptions(rawValue: keyboardAnimationCurve)) {
                self.commentToolbarBottomConstraint.constant = isKeyboardShowing ? keyboardFrame!.height - 34.0 : 0
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func makeCall() {
        guard let url = URL(string: NetworkingValues.apiUrl + "/comments/stories/\(story.storyID)") else { return }
        let urlRequest = URLRequest(url: url)
        print(urlRequest)
        
        AF.request(urlRequest).validate().responseDecodable(of: CommentsResponse.self) { [weak self] (response) in
            guard let storyResponse = response.value else {
                return
            }
            self?.comments.removeAll()
            self?.comments.append(contentsOf: storyResponse.data)
            self?.commentsTable.reloadData()
            self?.commentsTable.heightAnchor.constraint(equalToConstant: CGFloat((self?.comments.count)! * 80)).isActive = true
            self?.commentsTable.maxHeight = CGFloat(((self?.comments.count)! + 2) * 80)
//            self?.commentsTable.contentSize.height = (self?.commentsTable.frame.height)!
            self?.view.layoutIfNeeded()
        }
    }
    
    @IBAction func postCommentTapped(_ sender: Any) {
        if AuthenticationManager().currentSessionIsActive() {
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
            textView.resignFirstResponder()
            guard let comment = textView.text else {
                AlertsController().generateAlert(withError: ErrorMessage.missingData)
                return
            }
            CommentManager().publishComment(storyID: story.storyID, comment: comment) { [weak self] (state, message) in
                if state {
                    AlertsController().generateAlert(withSuccess: message)
                    self?.textView.text = ""
                    self!.makeCall()
                    self?.commentsTable.reloadData()
                } else {
                    AlertsController().generateAlert(withError: message)
                }
            }
        } else {
            AlertsController().generateAlert(withError: "Please sign in or create an account first before you comment.")
        }
    }
    
    @IBAction func shareStoryButton(_ sender: Any) {
        let message = "Hey! I found this article on Future Now Motivation. Check it out!"
        let url = "https://wp.me"
        
        let activityViewController = UIActivityViewController(activityItems: [message, url], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.storyTitleLabel
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    func initialize() {
        commentsTable.delegate = self
        commentsTable.dataSource = self
        commentsTable.emptyDataSetSource = self
        commentsTable.emptyDataSetDelegate = self
        
        if let thumbnailURL = story.postThumbnail {
            if thumbnailURL.isValidURL {
                postThumbnail.getImageFromURL(using: thumbnailURL)
            } else {
                postThumbnail.image = UIImage(named: "placeholder")
            }
        } else {
            postThumbnail.image = UIImage(named: "placeholder")
        }
        
        storyTitleLabel.text = story.title
        storyMetaLabel.text = "By \(story.username.capitalizingFirstLetter())"
        storyCategoryLabel.text = story.communityTitle.capitalizingFirstLetter()
        storyBodyTextView.text = story.body
        
        commentsTable.register(UINib(nibName: "CommentsTableViewCell", bundle: nil), forCellReuseIdentifier: "commentsIdentifier")
        commentsTable.translatesAutoresizingMaskIntoConstraints = false
        
        tagsCollectionView.register(UINib(nibName: "TagsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "tagsIdentifier")
    }
    
    fileprivate func configureTextView() {
        storyBodyTextView.textContainerInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}

extension StoryDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "commentsIdentifier")
                as? CommentsTableViewCell else { return UITableViewCell() }
        cell.configureCells(using: comments[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}

extension StoryDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagsIdentifier", for: indexPath) as? TagsCollectionViewCell else { return UICollectionViewCell()}
//        cell.configureCells(using: tags[indexPath.row])
        cell.title.text = tags[indexPath.row].lowercased()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100.0, height: 24.0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 15.0, bottom: 0.0, right: 15.0)
    }
    
}
extension StoryDetailViewController: DZNEmptyDataSetDelegate, DZNEmptyDataSetSource {
    func emptyDataSetShouldFade(in scrollView: UIScrollView) -> Bool {
        return true
    }
    // Add a title to your empty data set
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "No comments. Be the first to comment!"
        let attribs = [
            NSAttributedString.Key.font: UIFont(name: "Futura", size: 16.0)!,
            NSAttributedString.Key.foregroundColor: UIColor(named: "MediumGray")!
        ]
        
        return NSAttributedString(string: text, attributes: attribs)
    }
    // Set the background color of your empty data set
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return UIColor.systemBackground
    }
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return 0
    }

}

extension StoryDetailViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
}
