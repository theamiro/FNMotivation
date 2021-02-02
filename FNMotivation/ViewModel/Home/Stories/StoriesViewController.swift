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
import XLPagerTabStrip

// MARK: - StoryData
struct StoryResponse: Codable{
    let success: Bool
    let data: [Story]
}

// MARK: - Story
struct Story: Codable {
    let storyID: Int
    let title, body: String
    let postThumbnail: String?
    let communityTitle: String
    let userID: Int
    let username: String
    let communityThumbnail: String
    
    enum CodingKeys: String, CodingKey {
        case storyID = "story_id"
        case title, body
        case postThumbnail = "post_thumbnail"
        case communityTitle = "community_title"
        case userID = "user_id"
        case username
        case communityThumbnail = "community_thumbnail"
    }
}

class StoriesViewController: FNViewController, IndicatorInfoProvider {
    let reuseIdentifier = "storyCell"
    @IBOutlet weak var collectionView: UICollectionView!
    let refreshControl = UIRefreshControl()
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var stories: [Story] =  []
    var selectedStory: Story?
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "STORIES")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
//        configureEmptyDataSet()
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(makeCall), for: .valueChanged)
        makeCall()
    }
    
    @objc func makeCall() {
        guard let url = URL(string: NetworkingValues.apiUrl + "/stories?from=0&to=100") else { return }
        let urlRequest = URLRequest(url: url)
        
        AF.request(urlRequest).validate().responseDecodable(of: StoryResponse.self) { (response) in
            guard let storyResponse = response.value else {
                return
            }
            let stories = storyResponse.data
            self.stories.removeAll(keepingCapacity: false)
            for story in stories {
                self.stories.append(story)
            }
            self.collectionView.reloadData()
            self.activityIndicator.stopAnimating()
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
            self.activityIndicator.isHidden = true
        }
    }
    
    func configureEmptyDataSet() {
        collectionView.emptyDataSetSource = self
        collectionView.emptyDataSetDelegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailView" {
            if let storyDetailViewController = segue.destination as? StoryDetailViewController {
                storyDetailViewController.story = selectedStory
            }
        }
    }
}

extension StoriesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! StoryCollectionViewCell
        cell.delegate = self
        cell.configure(using: stories[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let story = stories[indexPath.row]
        selectedStory = story
        
        if let baseViewController = self.navigationController?.tabBarController?.parent as? BaseViewController {
//            baseViewController.recognizer.isEnabled = false
            if baseViewController.menuVisible {
                baseViewController.hideSideMenu()
            }
        }
        self.performSegue(withIdentifier: "toDetailView", sender: self)
    }
}

extension StoriesViewController: StoryCollectionViewFunctionsDelegate {
    func postComment(indexPath: IndexPath?) {
//        self.performSegue(withIdentifier: "toDetailView", sender: self)
        
    }
    
    func likeStory(indexPath: IndexPath?) {
        
    }
    
    func shareStory(cell: StoryCollectionViewCell) {
        let message = "Hey! I found this article on Future Now Motivation. Check it out!"
        let url = "https://wp.me"
        
        let activityViewController = UIActivityViewController(activityItems: [message, url], applicationActivities: nil)
//        activityViewController.popoverPresentationController?.sourceView = self.storyTitleLabel
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func followAuthor(cell: StoryCollectionViewCell) {
        if AuthenticationManager().currentSessionIsActive() {
//            AlertsController().generateAlert(withSuccess: "Followed the Author")
            
        } else {
            let authenticationViewController = UIStoryboard(name: "Main", bundle:
                Bundle.main).instantiateViewController(withIdentifier:
                    "authenticationViewController") as! AuthenticationViewController
            authenticationViewController.modalPresentationStyle = .formSheet
            self.present(authenticationViewController, animated: true, completion: nil)
        }
    }
}

extension StoriesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 40.0, height: 200.0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offset = scrollView.contentOffset.y
//        navigationController?.navigationBar.transform = .init(translationX: 0.0, y: min(0, -offset))
//    }
}

extension StoriesViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func emptyDataSetShouldFade(in scrollView: UIScrollView) -> Bool {
        return true
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        let image = UIImage(named: "icn_about_me")
        scrollView.tintColor = .systemBackground
        return image
    }
    
    // Add a title to your empty data set
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "Sorry, no stories at this time."
        let attribs = [
            NSAttributedString.Key.font: UIFont(name: "Futura", size: 20.0)!,
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
            NSAttributedString.Key.font: UIFont(name: "Futura", size: 14.0)!,
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
        makeCall()
    }
    
    // Set the background color of your empty data set
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return UIColor.systemBackground
    }
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return 0
    }
}
