//
//  Images.swift
//  FNMotivation
//
//  Created by Michael Amiro on 05/08/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()
extension UIImageView {
    public func getImageFromURL(using urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
            self.image = cachedImage
            return
        }
        
        let activityIndicator = UIActivityIndicatorView()
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 15.0).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 15.0).isActive = true
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    self.image = image
                    activityIndicator.removeFromSuperview()
                }
            }
        }.resume()
    }
}
