//
//  VaneView.swift
//  MGXWeather
//
//  Created by Miu on 2019/5/6.
//  Copyright © 2019 MGX. All rights reserved.
//

import UIKit

class VaneLayer: CALayer {
    
    let centerPoint = CALayer()
    let vane1 = CALayer()
    let vane2 = CALayer()
    let vane3 = CALayer()
    var isAnimating = false
    var animDuration:CFTimeInterval = 0
    //MARK: LifeCycle
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //Public
    func build() -> Void {
        setupVanes()
        setupCenterPoint()
        addNotifications()
    }
    
    
    func showAnimation(duration:CFTimeInterval) -> Void {
        removeAllAnimations()
        isAnimating = true
        animDuration = duration
        let anim = CABasicAnimation(keyPath: "transform.rotation.z")
        anim.toValue = CGFloat.pi * 2
        anim.duration = duration
        anim.repeatCount = Float.infinity
        self.add(anim, forKey: nil)
    }
    
    
    
    
    //MARK: Event
    func addNotifications() -> Void {
        NotificationCenter.default.addObserver(self, selector: #selector(appDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appDidBecomeActive), name: .WeatherDataWillShow, object: nil)
    }
    
    @objc func appDidBecomeActive() -> Void {
        if isAnimating {
            showAnimation(duration: animDuration)
        }
    }
    
    //SubLayer
    override func layoutSublayers() {
        super.layoutSublayers()
        layoutVanes()
        layoutCenterPoint()
    }
    
    //CenterPoint
    func setupCenterPoint() -> Void {
        centerPoint.backgroundColor = UIColor.black.cgColor
        centerPoint.cornerRadius = 2
        addSublayer(centerPoint)
    }
    func layoutCenterPoint() -> Void {
        centerPoint.bounds = CGRect(x: 0, y: 0, width: 4, height: 4)
        centerPoint.position = CGPoint(x: bounds.width * 0.5, y: bounds.height * 0.5)
    }
    
    //Vanes
    func setupVanes() -> Void {
        let img = UIImage(named: "WindSpeed")?.cgImage
        vane1.contents = img
        vane1.contentsScale = UIScreen.main.scale
        vane1.contentsGravity = .resizeAspect
        vane2.contents = img
        vane2.contentsScale = UIScreen.main.scale
        vane3.contents = img
        vane3.contentsScale = UIScreen.main.scale
        addSublayer(vane1)
        addSublayer(vane2)
        addSublayer(vane3)

    }
    func layoutVanes() -> Void {
        
        func radian(angle:CGFloat) -> CGFloat {
            return angle * CGFloat.pi/180
        }
        vane1.bounds = CGRect(x: 0, y: 0, width: 6, height: 31)
        vane1.anchorPoint = CGPoint(x: 0.5, y: 1)
        vane1.position = CGPoint(x: bounds.width * 0.5, y: bounds.height * 0.5)
        
        vane2.bounds = CGRect(x: 0, y: 0, width: 6, height: 31)
        vane2.anchorPoint = CGPoint(x: 0.5, y: 1)
        vane2.position = CGPoint(x: bounds.width * 0.5, y: bounds.height * 0.5)
        vane2.transform = CATransform3DMakeRotation(radian(angle: 120), 0, 0, 1)
        
        vane3.bounds = CGRect(x: 0, y: 0, width: 6, height: 31)
        vane3.anchorPoint = CGPoint(x: 0.5, y: 1)
        vane3.position = CGPoint(x: bounds.width * 0.5, y: bounds.height * 0.5)
        vane3.transform = CATransform3DMakeRotation(radian(angle: 240), 0, 0, 1)
    }
    

}
