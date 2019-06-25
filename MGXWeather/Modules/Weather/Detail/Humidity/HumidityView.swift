//
//  HumidityView.swift
//  MGXWeather
//
//  Created by Miu on 2019/4/29.
//  Copyright © 2019 MGX. All rights reserved.
//

import UIKit

class HumidityView: UIView, ViewRenderingProtocol{
    let titleLabel = UILabel()
    //背景圆
    let bgCircleLayer = CAShapeLayer()
    //进度圆
    let progressCircleLayer = CAShapeLayer()
    //湿度
    let humidityLabel = AnimatableCountLabel()
    
    public func build() -> Void {
        setupTitleLabel()
        setupBgCircleLayer()
        setupProgressCircleLayer()
        setupHumidityLabel()
        buildPresenter()
    }
    
    //MARK: SubViews
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutTitleLabel()
        layoutBgCircleLayer()
        layoutProgressCircleLayer()
        layoutHumidityLabel()
    }
    
    //Title
    func setupTitleLabel() -> Void {
        titleLabel.text = "Humidity"
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.light)
        addSubview(titleLabel)
    }
    func layoutTitleLabel() -> Void {
        titleLabel.frame.origin = CGPoint(x: 20, y: 10)
        titleLabel.sizeToFit()
    }
    
    //Circle
    func setupBgCircleLayer() -> Void {
        bgCircleLayer.lineWidth = 2
        bgCircleLayer.fillColor = UIColor.white.cgColor
        bgCircleLayer.strokeColor = UIColor.lightGray.cgColor
        bgCircleLayer.strokeStart = 0
        bgCircleLayer.strokeEnd = 0
        layer.addSublayer(bgCircleLayer)
    }
    func layoutBgCircleLayer() -> Void {
        let radius = min(bounds.width, bounds.height) - 80
        bgCircleLayer.path = UIBezierPath(arcCenter: CGPoint(x: bounds.width * 0.5, y: bounds.height * 0.5), radius: radius/2, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true).cgPath
    }
    
    //ProgressCircle
    func setupProgressCircleLayer() -> Void {
        progressCircleLayer.lineWidth = 2
        progressCircleLayer.fillColor = UIColor.white.cgColor
        progressCircleLayer.strokeColor = UIColor.black.cgColor
        progressCircleLayer.strokeStart = 0
        progressCircleLayer.strokeEnd = 0
        progressCircleLayer.lineCap = .round
        layer.addSublayer(progressCircleLayer)
    }
    func layoutProgressCircleLayer() -> Void {
        progressCircleLayer.path = bgCircleLayer.path
    }
    
    //HumidityLabel
    func setupHumidityLabel() -> Void {
        humidityLabel.textColor = UIColor.black
        humidityLabel.textAlignment = .center
        humidityLabel.timingFunction = .easeInOut
        humidityLabel.formatString = "%"
        humidityLabel.font = UIFont.systemFont(ofSize: 34, weight: .light)
        addSubview(humidityLabel)
    }
    func layoutHumidityLabel() -> Void {
        humidityLabel.frame = bounds
    }
}


//MARK: ViewRenderingProtocol
extension HumidityView {
    func buildPresenter() {
        presenter = HumidityPresenter.init()
        presenter?.attachView(view: self)
    }
    
    func renderingView(viewModel: Any) {
        let humidity = viewModel as! Int
        doBgCircleAnimation()
        doProgressCircleAnimation(toValue: Double(humidity) * 0.01)
        humidityLabel.count(from: 0, to: humidity, duration: 2)
    }
    
    func eraseView() {
        bgCircleLayer.strokeEnd = 0
        progressCircleLayer.strokeEnd = 0
        humidityLabel.text = nil
        humidityLabel.reset()
    }
    
}

//MARK: Animation
extension HumidityView {
    func doBgCircleAnimation() -> Void {
        CATransaction.begin()
        CATransaction.setAnimationDuration(3)
        bgCircleLayer.strokeEnd = 1
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.easeInEaseOut))
        CATransaction.commit()
    }
    
    func doProgressCircleAnimation(toValue:Double) -> Void {
        CATransaction.begin()
        CATransaction.setAnimationDuration(2.5)
        progressCircleLayer.strokeEnd = CGFloat(toValue)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.easeInEaseOut))
        CATransaction.commit()
    }

}
