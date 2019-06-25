//
//  WeatherIconView.swift
//  MGXWeather
//
//  Created by Miu on 2019/4/25.
//  Copyright © 2019 MGX. All rights reserved.
//

import UIKit

class WeatherIconView: UIView,ViewRenderingProtocol {
    
    let titleLabel = UILabel()
    let iconLabel = UILabel()
    let blendLayer = CALayer()
    var isAnimating = false
    
    public func build() -> Void {
        setupTitleLabel()
        setupIconLabel()
        setupBlendLayer()
        buildPresenter()
        addNotifications()
    }
    
    //MARK: LifeCycle
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: Event
    func addNotifications() -> Void {
        NotificationCenter.default.addObserver(self, selector: #selector(appDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    @objc func appDidBecomeActive() -> Void {
        if isAnimating {
            setupBlendLayerAnimation()
        }
    }
    

    
    //MARK: SubViews
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutTitleLabel()
        layoutIconLabel()
        layoutBlendLayer()
    }
    
    //Title
    func setupTitleLabel() -> Void {
        titleLabel.text = "Weather"
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.light)
        addSubview(titleLabel)
    }
    func layoutTitleLabel() -> Void {
        titleLabel.frame.origin = CGPoint(x: 20, y: 10)
        titleLabel.sizeToFit()
    }
    
    //Icon
    func setupIconLabel() -> Void {
        iconLabel.font = UIFont(name: "Weather&Time", size: 110)
        iconLabel.textAlignment = .center
        addSubview(iconLabel)
    }
    func layoutIconLabel() -> Void {
        iconLabel.frame = bounds
    }
    
    //BlendLayer
    func setupBlendLayer() -> Void {
        blendLayer.shadowRadius = 2
        blendLayer.opacity = 0
        layer.addSublayer(blendLayer)
    }
    func layoutBlendLayer() -> Void {
        blendLayer.frame = bounds
    }
    func setupBlendLayerContent(fillColor:UIColor) -> Void {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        //截取原图
        layer.render(in: UIGraphicsGetCurrentContext()!)
        //对原图进行颜色混合
        fillColor.setFill()
        let path = UIBezierPath(rect: bounds)
        path.fill(with: .sourceAtop, alpha: 1)
        
        //设置图片
        let image = UIGraphicsGetImageFromCurrentImageContext()
        blendLayer.contents = image?.cgImage
        UIGraphicsEndImageContext()
        
        //开启动画
        setupBlendLayerAnimation()
    }
    
    func setupBlendLayerAnimation() -> Void {
        blendLayer.removeAllAnimations()
        isAnimating = true
        let opacityAnim = CABasicAnimation(keyPath: "opacity")
        opacityAnim.duration = 2;
        opacityAnim.fromValue = 0
        opacityAnim.toValue = 1
        opacityAnim.autoreverses = true
        opacityAnim.repeatCount = Float.infinity
        blendLayer.add(opacityAnim, forKey: nil)
    }
}

//MARK: ViewRenderingProtocol
extension WeatherIconView {
    func buildPresenter() {
        presenter = WeatherIconPresenter.init()
        presenter?.attachView(view: self)
    }
    
    func renderingView(viewModel: Any) {
        let weatherData = viewModel as? String
        blendLayer.shadowColor = UIColor.orange.cgColor
        iconLabel.text = weatherData
        setupBlendLayerContent(fillColor: UIColor.orange)
    }
    
    func eraseView() {
        iconLabel.text = nil;
        blendLayer.removeAllAnimations()
    }
    
}
