//
//  LinksViewController.swift
//  FNMotivation
//
//  Created by Michael Amiro on 20/09/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit
import Alamofire
import DZNEmptyDataSet
import XLPagerTabStrip

// MARK: - ArticleData
struct ArticleResponse: Codable {
    let success: Bool
    let data: [Article]
}

// MARK: - Article
struct Article: Codable {
    let id: Int
    let title: String
    let redirectLink: String
    let communityTitle, username: String
    let userID: Int
    let avatar: String
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case redirectLink = "redirect_link"
        case communityTitle = "community_title"
        case username
        case userID = "user_id"
        case avatar
        case createdAt = "created_at"
    }
}

class ArticlesViewController: FNViewController, IndicatorInfoProvider {
    let reuseIdentifier = "articleCell"
    @IBOutlet weak var collectionView: UICollectionView!
    let refreshControl = UIRefreshControl()
    
    var articles: [Article] =  []
    var selectedArticle: Article?

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "ARTICLES")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: NetworkingValues.apiUrl + "/posts?from=0&to=100") else { return }
        let urlRequest = URLRequest(url: url)
        
        AF.request(urlRequest).validate().responseDecodable(of: ArticleResponse.self) { (response) in
            guard let articleResponse = response.value else {
                return
            }
            let articles = articleResponse.data
            
            for article in articles {
                self.articles.append(article)
            }
            self.collectionView.reloadData()
        }
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
//        configureEmptyDataSet()
    }
    
    @objc private func refreshData() {
        
    }
}
extension ArticlesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ArticleCollectionViewCell
        cell.titleLabel.text = articles[indexPath.row].title
        cell.categoryLabel.text = articles[indexPath.row].communityTitle.capitalizingFirstLetter()
        cell.authorLabel.text = "By \(articles[indexPath.row].userID) on"
        //        \(stories[indexPath.row].created.getDate())
        cell.excerptLabel.text = articles[indexPath.row].redirectLink
        cell.delegate = self
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let article = articles[indexPath.row]
        selectedArticle = article
        
        if let baseViewController = self.navigationController?.tabBarController?.parent as? BaseViewController {
            //            baseViewController.recognizer.isEnabled = false
            if baseViewController.menuVisible {
                baseViewController.hideSideMenu()
            }
        }
        self.performSegue(withIdentifier: "toDetailView", sender: self)
    }
}
extension ArticlesViewController: ArticleCollectionViewFunctionsDelegate {
    func postComment(cell: ArticleCollectionViewCell) {}
    
    func loveStory(cell: ArticleCollectionViewCell) {}
    
    func shareStory(cell: ArticleCollectionViewCell) {
        let message = "Hey! I found this article on Future Now Motivation. Check it out!"
        let url = "https://wp.me"
        
        let activityViewController = UIActivityViewController(activityItems: [message, url], applicationActivities: nil)
        //        activityViewController.popoverPresentationController?.sourceView = self.storyTitleLabel
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func followAuthor(cell: ArticleCollectionViewCell) {
        let authenticationViewController = UIStoryboard(name: "Main", bundle:
            Bundle.main).instantiateViewController(withIdentifier:
                "authenticationViewController") as! AuthenticationViewController
        authenticationViewController.modalPresentationStyle = .formSheet
        self.present(authenticationViewController, animated: true, completion: nil)
    }
}

extension ArticlesViewController: UICollectionViewDelegateFlowLayout {
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

extension ArticlesViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
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
        refreshData()
    }
    
    // Set the background color of your empty data set
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return UIColor.systemBackground
    }
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return 0
    }
}
