//
//  CommunityViewController.swift
//  FNMotivation
//
//  Created by Michael Amiro on 20/07/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit

struct Community {
    var thumbnail: UIImage
    var title: String
    
    init(thumbnail: UIImage, title: String) {
        self.thumbnail = thumbnail
        self.title = title
    }
}

class CommunityViewController: FNViewController {
    let reuseIdentifier = "communityCell"
    
    var communities: [Community] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 1...20 {
            communities.append(Community(thumbnail: UIImage(named: "img_alcohol_addiction")!, title: "Alcohol Addiction"))
        }
    }
}
extension CommunityViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return communities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CommunityCollectionViewCell
        cell.communityNameLabel.text = communities[indexPath.row].title
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
