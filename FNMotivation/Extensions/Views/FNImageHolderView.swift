//
//  UIView.swift
//  FNMotivation
//
//  Created by Michael Amiro on 08/10/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit

class FNImageHolderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //        configureView()
    }
    
    private var shadowLayer: CAShapeLayer!
    private var cornerRadius: CGFloat = 10.0
    private var fillColor: UIColor = .white
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 10.0
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.fillColor = fillColor.cgColor
            
            shadowLayer.shadowColor = UIColor.black.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 1.0)
            shadowLayer.shadowOpacity = 0.2
            shadowLayer.shadowRadius = 6
            
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
}


//extension UIView {
//    func dropShadow() {
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
//        self.layer.shadowOpacity = 0.2
//        self.layer.shadowRadius = 6
//        self.layer.masksToBounds =  false
//    }
//}
