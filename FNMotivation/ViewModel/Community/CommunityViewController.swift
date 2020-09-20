//
//  CommunityViewController.swift
//  FNMotivation
//
//  Created by Michael Amiro on 20/07/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit
import Alamofire

// MARK: - Empty
struct CommunityResponse: Codable {
    let success: Bool
    let data: [Community]
}

// MARK: - Community
struct Community: Codable {
    let id: Int
    let title: String
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title = "community_title"
        case imageURL = "image_url"
    }
}

class CommunityViewController: FNViewController {
    let reuseIdentifier = "communityCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    let refreshControl = UIRefreshControl()
    
    var communities: [Community] = []
    var selectedCommunity: Community?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: NetworkingValues.apiUrl + "/communities") else { return }
        let urlRequest = URLRequest(url: url)
        
        AF.request(urlRequest).validate().responseDecodable(of: CommunityResponse.self) { (response) in
            guard let communityResponse = response.value else {
                return
            }
            let communities = communityResponse.data
            
            for community in communities {
                self.communities.append(community)
            }
            self.collectionView.reloadData()
        }
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    @objc
    private func refreshData() {
        
    }
}
extension CommunityViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return communities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CommunityCollectionViewCell
        cell.communityNameLabel.text = communities[indexPath.row].title
        cell.communityThumbnail.getImageFromURL(using: communities[indexPath.row].imageURL)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 3
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let width = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        
        return CGSize(width: width, height: 156)
    }
}
