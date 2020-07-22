//
//  HomeViewController.swift
//  FNMotivation
//
//  Created by Michael Amiro on 13/06/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController: FNViewController {
    let reuseIdentifier = "homeCell"
    
    var storyPosts: [Post] =  []
    var selectedPost: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 1...30 {
            storyPosts.append(Post(title: DummyData.loremIpsum.truncate(toLength: 50), meta: "By Amiro on 20/12/2019", category: "Heat Disease", body: DummyData.loremIpsum, link: "https://fnmotivation.com"))
        }
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
        cell.categoryLabel.text = storyPosts[indexPath.row].category
        cell.authorLabel.text = storyPosts[indexPath.row].meta
        cell.excerptLabel.text = storyPosts[indexPath.row].body
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print(indexPath.row)
        
        let post = storyPosts[indexPath.row]
        selectedPost = post
        
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
