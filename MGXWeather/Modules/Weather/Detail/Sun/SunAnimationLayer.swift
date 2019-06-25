//
//  SunriseView.swift
//  MGXWeather
//
//  Created by Miu on 2019/4/30.
//  Copyright © 2019 MGX. All rights reserved.
//

import UIKit

enum SunAnimationDirection {
    case topToBottom
    case bottomToTop
}

class SunAnimationLayer: CALayer {
    private var direction:SunAnimationDirection = .topToBottom
    private let sunLayer = CALayer()
    private let moonLayer = CALayer()
    private let line = CALayer()
    private let topLayer = CALayer()
    private let bottomLayer = CALayer()
    
    
    public func build(direction:SunAnimationDirection) -> Void {
        self.direction = direction
        setupTopLayer()
        setupBottomLayer()
        setupSun()
        setupMoon()
        setupLine()
    }
    
    public func reset() -> Void {
        if direction == .topToBottom {
            sunLayer.position = CGPoint(x: bounds.width * 0.5, y:topLayer.bounds.height * 0.5)
            moonLayer.position = CGPoint(x: bounds.width * 0.5, y: -bottomLayer.bounds.height * 0.5)
        }else {
            sunLayer.position = CGPoint(x: bounds.width * 0.5, y: topLayer.bounds.height * 1.5)
            moonLayer.position = CGPoint(x: bounds.width * 0.5, y: bottomLayer.bounds.height * 0.5)
        }
    }
    
    public func showAnimation() -> Void {
        if direction == .topToBottom {
            CATransaction.begin()
            CATransaction.setAnimationDuration(2)
            sunLayer.position.y = topLayer.bounds.height * 1.5
            moonLayer.position.y = bottomLayer.bounds.height * 0.5
            CATransaction.commit()
        }else {
            CATransaction.begin()
            CATransaction.setAnimationDuration(2)
            sunLayer.position.y = topLayer.bounds.height * 0.5
            moonLayer.position.y = -bottomLayer.bounds.height * 0.5
            CATransaction.commit()
        }
    }
    
    
    //MARK: SubLayers
    override func layoutSublayers() {
        super.layoutSublayers()
        layoutTopLayer()
        layoutBottomLayer()
        layoutLine()
        layoutSun()
        layoutMoon()
    }
    
    //Sun
    func setupSun() -> Void {
        sunLayer.contents = UIImage(named: "sun")?.cgImage
        sunLayer.contentsScale = UIScreen.main.scale
        topLayer.addSublayer(sunLayer)
    }
    func layoutSun() -> Void {
        sunLayer.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        if direction == .topToBottom {
            sunLayer.position = CGPoint(x: bounds.width * 0.5, y:topLayer.bounds.height * 0.5)
        }else {
            sunLayer.position = CGPoint(x: bounds.width * 0.5, y: topLayer.bounds.height * 1.5)
        }
    }
    
    //Moon
    func setupMoon() -> Void {
        moonLayer.contents = UIImage(named: "moon")?.cgImage
        moonLayer.contentsScale = UIScreen.main.scale
        bottomLayer.addSublayer(moonLayer)

    }
    func layoutMoon() -> Void {
        moonLayer.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        if direction == .topToBottom {
            moonLayer.position = CGPoint(x: bounds.width * 0.5, y: -bottomLayer.bounds.height * 0.5)
        }else {
            moonLayer.position = CGPoint(x: bounds.width * 0.5, y: bottomLayer.bounds.height * 0.5)
        }
    }
    
    //TopLayer
    func setupTopLayer() -> Void {
        topLayer.masksToBounds = true
        addSublayer(topLayer)
    }
    func layoutTopLayer() -> Void {
        topLayer.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height * 0.5)
    }
    
    //BottomLayer
    func setupBottomLayer() -> Void {
        bottomLayer.masksToBounds = true
        addSublayer(bottomLayer)
    }
    func layoutBottomLayer() -> Void {
        bottomLayer.frame = CGRect(x: 0, y: bounds.height * 0.5, width: bounds.width, height: bounds.height * 0.5)
    }
    
    //Line
    func setupLine() -> Void {
        line.backgroundColor = UIColor.lightGray.cgColor
        addSublayer(line)
    }
    func layoutLine() -> Void {
        line.frame = CGRect(x: 10, y: bounds.height * 0.5, width: bounds.width - 20, height: 1)
    }
    
}
