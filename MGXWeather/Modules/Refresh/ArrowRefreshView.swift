//
//  BottomRefreshView.swift
//  MGXWeather
//
//  Created by Miu on 2019/5/27.
//  Copyright © 2019 MGX. All rights reserved.
//

import UIKit



class ArrowRefreshView: UIView {
    let leftLayer = CAShapeLayer()
    let rightLayer = CAShapeLayer()
    
    public enum ArrowDirection {
        case up
        case down
    }
    
    public var direction = ArrowDirection.up
    
    public func build() {
        setupLeftLayer()
        setupRightLayer()
    }
    
    public func animation(percent: CGFloat) {
        var realPercent:CGFloat = 0
        if percent > 1 {
            realPercent = 1
        }else {
            realPercent = percent
        }
        
        let w = bounds.width * 0.5
        let leftPath = UIBezierPath()
        let rightPath = UIBezierPath()

        if direction == .up {
            let h = bounds.height * (1 - realPercent)
            leftPath.move(to: CGPoint(x: 0, y: bounds.height))
            leftPath.addLine(to: CGPoint(x: w, y: h))
            leftLayer.path = leftPath.cgPath
            
            rightPath.move(to: CGPoint(x: 0, y: h))
            rightPath.addLine(to: CGPoint(x: w, y: bounds.height))
        } else {
            let h = bounds.height * realPercent
            leftPath.move(to: CGPoint(x: 0, y: 0))
            leftPath.addLine(to: CGPoint(x: w, y: h))

            rightPath.move(to: CGPoint(x: 0, y: h))
            rightPath.addLine(to: CGPoint(x: w, y: 0))
        }
        

        leftLayer.path = leftPath.cgPath
        rightLayer.path = rightPath.cgPath
    }
    

    
    //MARK: Subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = bounds.width * 0.5
        leftLayer.frame = CGRect(x: 0, y: 0, width: width, height: bounds.height)
        rightLayer.frame = CGRect(x: width, y: 0, width: width, height: bounds.height)
    }
    
    private func setupLeftLayer() {
        leftLayer.fillColor = UIColor.clear.cgColor
        leftLayer.strokeColor = UIColor.red.cgColor
        leftLayer.lineWidth = 1
        layer.addSublayer(leftLayer)
    }
    
    private func setupRightLayer() {
        rightLayer.fillColor = UIColor.clear.cgColor
        rightLayer.strokeColor = UIColor.red.cgColor
        rightLayer.lineWidth = 1
        layer.addSublayer(rightLayer)
    }

}
