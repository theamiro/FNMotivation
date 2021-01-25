//
//  SelfSizedTableView.swift
//  FNMotivation
//
//  Created by Michael Amiro on 25/01/2021.
//  Copyright © 2021 Michael Amiro. All rights reserved.
//

import UIKit

class SelfSizedTableView: UITableView {
  var maxHeight: CGFloat = UIScreen.main.bounds.size.height
  
  override func reloadData() {
    super.reloadData()
    self.invalidateIntrinsicContentSize()
    self.layoutIfNeeded()
  }
  
  override var intrinsicContentSize: CGSize {
    let height = min(contentSize.height, maxHeight)
    return CGSize(width: contentSize.width, height: height)
  }
}
