//
//  SunInfoView.swift
//  MGXWeather
//
//  Created by Miu on 2019/4/29.
//  Copyright © 2019 MGX. All rights reserved.
//

import UIKit

class SunInfoView: UIView,ViewRenderingProtocol {
    let titleLabel = UILabel()
    let sunriseLabel = UILabel()
    let sunsetLabel = UILabel()
    let sunrise = SunAnimationLayer()
    let sunset = SunAnimationLayer()
    
    public func build() -> Void {
        setupTitleLabel()
        setupSunriseLabel()
        setupSunsetLabel()
        setupSunriseLayer()
        setupSunsetLayer()
        buildPresenter()
    }
    
    //MARK: SubViews
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutTitleLabel()
        layoutSunriseLayer()
        layoutSunsetLayer()
        layoutSunriseLabel()
        layoutSunsetLabel()
    }
    
    //Title
    func setupTitleLabel() -> Void {
        titleLabel.text = "Sunrise/Sunset"
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.light)
        addSubview(titleLabel)
    }
    func layoutTitleLabel() -> Void {
        titleLabel.frame.origin = CGPoint(x: 20, y: 10)
        titleLabel.sizeToFit()
    }
    
    //Sunrise time
    func setupSunriseLabel() -> Void {
        sunriseLabel.alpha = 0
        sunriseLabel.layer.zPosition = 10
        sunriseLabel.textAlignment = .center
        sunriseLabel.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        addSubview(sunriseLabel)
    }
    func layoutSunriseLabel() -> Void {
        sunriseLabel.frame = CGRect(x: sunrise.frame.minX, y: sunrise.position.y + 5, width: sunrise.frame.width, height: 20)
    }
    
    //Sunset time
    func setupSunsetLabel() -> Void {
        sunsetLabel.alpha = 0
        sunsetLabel.layer.zPosition = 10
        sunsetLabel.textAlignment = .center
        sunsetLabel.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        addSubview(sunsetLabel)
    }
    func layoutSunsetLabel() -> Void {
        sunsetLabel.frame = CGRect(x: sunset.frame.minX, y: sunset.position.y - 25, width: sunset.frame.width, height: 20)
    }
    
    //Sunrise
    func setupSunriseLayer() -> Void {
        sunrise.build(direction: .bottomToTop)
        sunrise.opacity = 0
        layer.addSublayer(sunrise)
    }
    func layoutSunriseLayer() -> Void {
        let width = bounds.width/3
        sunrise.frame = CGRect(x: bounds.width/2 - width, y: 40, width: width, height: bounds.height - 50)
    }
    
    //Sunset
    func setupSunsetLayer() -> Void {
        sunset.build(direction: .topToBottom)
        sunset.opacity = 0
        layer.addSublayer(sunset)
    }
    func layoutSunsetLayer() -> Void {
        let width = bounds.width/3
        sunset.frame = CGRect(x: bounds.width/2, y: 50, width: width, height: bounds.height - 50)
    }

}

//MARK: ViewRenderingProtocol
extension SunInfoView {
    func buildPresenter() {
        presenter = SunPresenter()
        presenter?.attachView(view: self)
    }
    
    func renderingView(viewModel: Any) {
        let tuple = viewModel as! (String,String)
        sunriseLabel.text = tuple.0
        sunsetLabel.text = tuple.1
        sunrise.opacity = 1
        sunset.opacity = 1
        sunrise.showAnimation()
        sunset.showAnimation()
        UIView.animate(withDuration: 2) {
            self.sunriseLabel.alpha = 1
            self.sunsetLabel.alpha = 1
        }
    }
    
    func eraseView() {
        sunrise.reset()
        sunset.reset()
        sunrise.opacity = 0
        sunset.opacity = 0
        sunriseLabel.alpha = 0
        sunsetLabel.alpha = 0
        sunsetLabel.text = nil
        sunriseLabel.text = nil;
    }
}
