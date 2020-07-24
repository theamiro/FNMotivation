//
//  HomeViewController.swift
//  FNMotivation
//
//  Created by Michael Amiro on 13/06/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit
import Alamofire

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
    let username: String
    
    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case title = "title"
        case communityCategories = "community_categories"
        case summary = "summary"
        case postThumbnail = "post_thumbnail"
        case story = "story"
        case tags = "tags"
        case username = "username"
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailView" {
            navigationController?.navigationBar.transform = .init(translationX: 0, y: 0)
            if let storyDetailViewController = segue.destination as? StoryDetailViewController {
                storyDetailViewController.post = selectedPost
            }
        }
    }
}
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storyPosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HomeViewCell
        cell.titleLabel.text = storyPosts[indexPath.row].title
        cell.categoryLabel.text = storyPosts[indexPath.row].communityCategories
        cell.authorLabel.text = storyPosts[indexPath.row].username
        cell.excerptLabel.text = storyPosts[indexPath.row].story
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print(indexPath.row)
        
        let post = storyPosts[indexPath.row]
        selectedPost = post
        
        if let baseViewController = self.navigationController?.tabBarController?.parent as? BaseViewController {
            if baseViewController.menuVisible {
                baseViewController.hideSideMenu()
            }
        }
        self.performSegue(withIdentifier: "toDetailView", sender: self)
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
