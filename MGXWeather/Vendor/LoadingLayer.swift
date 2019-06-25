//
//  LoadingLayer.swift
//  CoreAnimationCollection
//
//  Created by Miu on 2019/4/6.
//  Copyright © 2019 HS. All rights reserved.
//

import UIKit

class LoadingLayer: CAReplicatorLayer {
    
    public var dotColor:CGColor = UIColor.lightGray.cgColor
    public var animDuration:CGFloat = 1
    public var dotCount:Int = 10
    
    
    private var isAnimating:Bool = false
    private var animLayer:CALayer = CALayer()
    
    override init() {
        super.init()
        self.addNotification()
        self.addSublayer(animLayer)
    }
    
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: Event
    func addNotification() -> Void {
        NotificationCenter.default.addObserver(self, selector: #selector(appDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    @objc func appDidBecomeActive() -> Void {
        if isAnimating {
            self.start()
        }
    }
    
    //MARK: Public
    func start() -> Void {
        self.stop()
        isAnimating = true
        instanceCount = dotCount
        instanceDelay = Double(animDuration)/Double(instanceCount)
        instanceTransform = CATransform3DMakeRotation((CGFloat.pi * 2)/CGFloat(instanceCount), 0, 0, 1)
        
        let raidus:CGFloat = 6
        animLayer.bounds = CGRect(x: 0, y: 0, width: raidus, height: raidus)
        animLayer.cornerRadius = raidus * 0.5
        animLayer.position = CGPoint(x: self.bounds.width * 0.5, y: raidus * 0.5)
        animLayer.backgroundColor = dotColor
        animLayer.transform = CATransform3DMakeScale(0, 0, 0)
        
        let scaleAnim = CABasicAnimation(keyPath: "transform.scale")
        scaleAnim.fromValue = 1
        scaleAnim.toValue = 0.1
        scaleAnim.duration = CFTimeInterval(animDuration)
        scaleAnim.repeatCount = Float.infinity
        animLayer.add(scaleAnim, forKey: "loading")
    }
    
    func stop() -> Void {
        animLayer.removeAllAnimations()
        isAnimating = false
    }
}
