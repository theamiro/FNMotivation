//
//  HomeViewController.swift
//  FNMotivation
//
//  Created by Michael Amiro on 13/06/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit
import Alamofire
import DZNEmptyDataSet

// MARK: - StoryData
struct StoryResponse: Codable{
    let success: Bool
    let data: [Story]
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case data = "data"
    }
}

// MARK: - Post
struct Story: Codable {
    let postID: Int
    let title: String
    let communityCategories: String
    let summary: String
    let postThumbnail: String
    let story: String
    let tags: String
    let userID: Int
    let created: String
    
    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case title = "title"
        case communityCategories = "community_categories"
        case summary = "summary"
        case postThumbnail = "post_thumbnail"
        case story = "story"
        case tags = "tags"
        case userID = "user_id"
        case created = "createdAt"
    }
}

class HomeViewController: FNViewController {
    let reuseIdentifier = "homeCell"
    @IBOutlet weak var collectionView: UICollectionView!
    let refreshControl = UIRefreshControl()
    
    var storyPosts: [Story] =  []
    var selectedPost: Story?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureEmptyDataSet()
        
        guard let url = URL(string: NetworkingValues.apiUrl + "/posts") else { return }
        let urlRequest = URLRequest(url: url)
        
        
        AF.request(urlRequest).validate().responseDecodable(of: StoryResponse.self) { (response) in
            guard let storyResponse = response.value else {
                return
            }
            let stories = storyResponse.data
            
            for story in stories {
                self.storyPosts.append(story)
            }
            self.collectionView.reloadData()
        }
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc func refreshData() {
        
    }
    
    func configureEmptyDataSet() {
        collectionView.emptyDataSetSource = self
        collectionView.emptyDataSetDelegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailView" {
            navigationController?.navigationBar.transform = .init(translationX: 0, y: 0)
            if let storyDetailViewController = segue.destination as? StoryDetailViewController {
                storyDetailViewController.post = selectedPost
            }
        }
    }
//    func getProfile(forUser userID: Int) {
//        NetworkingService.shared.makeCall(fromUrl: NetworkingValues.apiUrl + "/users/profile/\(userID)", networkCallType: .get) { (state, message, dataObject) in
//            if state {
//                guard let response = dataObject as? [String: Any],
//                    let username = response["username"] as? String else {
//                        print("error getting profile")
//                        return
//                }
//                print(username)
//            }
//        }
//    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storyPosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HomeViewCell
        cell.titleLabel.text = storyPosts[indexPath.row].title
        cell.categoryLabel.text = storyPosts[indexPath.row].communityCategories.capitalizingFirstLetter()
        cell.authorLabel.text = "By \(storyPosts[indexPath.row].userID) on \(storyPosts[indexPath.row].created.getDate())"
        cell.excerptLabel.text = storyPosts[indexPath.row].story
        cell.delegate = self
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let post = storyPosts[indexPath.row]
        selectedPost = post
        
        if let baseViewController = self.navigationController?.tabBarController?.parent as? BaseViewController {
//            baseViewController.recognizer.isEnabled = false
            if baseViewController.menuVisible {
                baseViewController.hideSideMenu()
            }
        }
        self.performSegue(withIdentifier: "toDetailView", sender: self)
    }
}

extension HomeViewController: HomeCollectionViewFunctionsDelegate {
    func postComment(cell: HomeViewCell) {}
    
    func loveStory(cell: HomeViewCell) {}
    
    func shareStory(cell: HomeViewCell) {
        let message = "Hey! I found this article on Future Now Motivation. Check it out!"
        let url = "https://wp.me"
        
        let activityViewController = UIActivityViewController(activityItems: [message, url], applicationActivities: nil)
//        activityViewController.popoverPresentationController?.sourceView = self.storyTitleLabel
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func followAuthor(cell: HomeViewCell) {
        let authenticationViewController = UIStoryboard(name: "Main", bundle:
            Bundle.main).instantiateViewController(withIdentifier:
                "authenticationViewController") as! AuthenticationViewController
        authenticationViewController.modalPresentationStyle = .formSheet
        self.present(authenticationViewController, animated: true, completion: nil)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 40.0, height: 200.0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        navigationController?.navigationBar.transform = .init(translationX: 0.0, y: min(0, -offset))
    }
}

extension HomeViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func emptyDataSetShouldFade(in scrollView: UIScrollView) -> Bool {
        return true
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        let image = UIImage(named: "icn_about_me")
        scrollView.tintColor = UIColor(named: "BlueWhite")!
        return image
    }
    
    // Add a title to your empty data set
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "Sorry, no stories at this time."
        let attribs = [
            NSAttributedString.Key.font: UIFont(name: "Avenir Next", size: 24.0)!,
            NSAttributedString.Key.foregroundColor: UIColor(named: "MediumGray")!
        ]
        
        return NSAttributedString(string: text, attributes: attribs)
    }
    
    // Add a description to your empty data set
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "It's either us or you. Can't figure it out!"
        
        let para = NSMutableParagraphStyle()
        para.lineBreakMode = NSLineBreakMode.byWordWrapping
        para.alignment = NSTextAlignment.center
        let attribs = [
            NSAttributedString.Key.font: UIFont(name: "Avenir Next", size: 14.0)!,
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
            NSAttributedString.Key.paragraphStyle: para
        ]
        return NSAttributedString(string: text, attributes: attribs)
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView, for state: UIControl.State) -> NSAttributedString? {
        let text = "Try again"
        let attribs = [
            NSAttributedString.Key.font: UIFont(name: "Futura-Medium", size: 14.0)!
        ]
        return NSAttributedString(string: text, attributes: attribs)
    }
    
    func emptyDataSet(_ scrollView: UIScrollView, didTap button: UIButton) {
        refreshData()
    }
    
    // Set the background color of your empty data set
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return UIColor(named: "BlueWhite")!
    }
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return 0
    }
}
