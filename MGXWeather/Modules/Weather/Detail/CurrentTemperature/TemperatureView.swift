//
//  TemperatureView.swift
//  MGXWeather
//
//  Created by Miu on 2019/4/26.
//  Copyright © 2019 MGX. All rights reserved.
//

import UIKit

class TemperatureView: UIView,ViewRenderingProtocol {
    let titleLabel = UILabel()
    let temperatureLabel = AnimatableCountLabel()
    public func build() -> Void {
        setupTitleLabel()
        setupTemperature()
        buildPresenter()
    }
    
    //MARK: SubViews
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutTitleLabel()
        layoutTemperatureLabel()
    }
    
    
    //Title
    func setupTitleLabel() -> Void {
        titleLabel.text = "Temperature ℃"
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.light)
        addSubview(titleLabel)
    }
    func layoutTitleLabel() -> Void {
        titleLabel.frame.origin = CGPoint(x: 20, y: 10)
        titleLabel.sizeToFit()
    }
    
    //Temperature
    func setupTemperature() -> Void {
        temperatureLabel.textColor = UIColor.blue
        temperatureLabel.textAlignment = .center
        temperatureLabel.timingFunction = .easeInOut
        temperatureLabel.formatString = " °"
        temperatureLabel.font = UIFont.systemFont(ofSize: 72, weight: .ultraLight)
        addSubview(temperatureLabel)
    }
    
    func layoutTemperatureLabel() -> Void {
        temperatureLabel.frame = bounds
    }
}

//MARK:ViewRenderingProtocol
extension TemperatureView {
    func buildPresenter() {
        presenter = TemperaturePresenter()
        presenter?.attachView(view: self)
    }
    func renderingView(viewModel: Any) {
        let temperature = viewModel as! Int
        var duration = temperature/6
        if duration < 2 {
            duration = 2
        }
        temperatureLabel.count(from: 0, to: temperature, duration: TimeInterval(duration))
    }
    func eraseView() {
        temperatureLabel.text = nil
        temperatureLabel.reset()
    }
}
