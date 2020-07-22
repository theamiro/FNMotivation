//
//  FNView.swift
//  FNMotivation
//
//  Created by Michael Amiro on 14/07/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit

class FNView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
//        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        configureView()
    }

//    private func configureView() {
//        layer.backgroundColor = UIColor.clear.cgColor
//
//        layer.shadowColor = UIColor.gray.cgColor
//        layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
//        layer.shadowOpacity = 0.5
//        layer.shadowRadius = 6
//        clipsToBounds = false
//
//
//        layer.masksToBounds = false
//    }
    private var shadowLayer: CAShapeLayer!
    private var cornerRadius: CGFloat = 25.0
    private var fillColor: UIColor = .red // the color applied to the shadowLayer, rather than the view's backgroundColor
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.fillColor = fillColor.cgColor
            
            shadowLayer.shadowColor = UIColor.label.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 1.0)
            shadowLayer.shadowOpacity = 0.2
            shadowLayer.shadowRadius = 6
            
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
}
