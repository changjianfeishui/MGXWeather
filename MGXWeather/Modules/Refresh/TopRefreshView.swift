//
//  RefreshView.swift
//  MGXWeather
//
//  Created by Miu on 2019/5/8.
//  Copyright © 2019 MGX. All rights reserved.
//

import UIKit

class TopRefreshView: UIView {

    public var text = "Release To Update"
    public var font = UIFont.systemFont(ofSize: 20)
    public var textColor = UIColor.red
    public var textWidth:CGFloat = 0.5
    private let textLayer = CAShapeLayer()
    
    public func build() {
        textLayer.isGeometryFlipped = true
        textLayer.lineWidth = textWidth
        textLayer.fillColor = UIColor.clear.cgColor
        textLayer.strokeColor = textColor.cgColor
        textLayer.path = UIBezierPath.path(for: text, font: UIFont.systemFont(ofSize: 20, weight: .light)).cgPath
        textLayer.bounds = textLayer.path!.boundingBox
        textLayer.strokeEnd = 0
        layer.addSublayer(textLayer)
    }
    
    public func animation(percent: CGFloat) {
        if percent < 0 {
            return
        }
        let strokeEnd = percent > 1 ? 1 : percent
        textLayer.strokeEnd = strokeEnd
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
    }
}
