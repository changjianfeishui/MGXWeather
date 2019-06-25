//
//  TemperatureRangeView.swift
//  MGXWeather
//
//  Created by Miu on 2019/4/30.
//  Copyright © 2019 MGX. All rights reserved.
//

import UIKit

class TemperatureRangeView: UIView,ViewRenderingProtocol {

    let titleLabel = UILabel()
    let line = CALayer()
    let minTemp = UIView()
    let maxTemp = UIView()
    let minTempLabel = AnimatableCountLabel()
    let maxTempLabel = AnimatableCountLabel()
    
    let minDescriptionLabel = UILabel()
    let maxDescriptionLabel = UILabel()
    
    public func build() -> Void {
        setupTitleLabel()
        setupLine()
        setupMinTemp()
        setupMaxTemp()
        setupDescriptionLabel()
        setupTempLabel()
        buildPresenter()
    }
    
    //MARK: SubViews
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutTitleLabel()
        layoutLine()
        layoutDescriptionLabel()
    }
    
    //Title
    func setupTitleLabel() -> Void {
        titleLabel.text = "Temp Range ℃"
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.light)
        addSubview(titleLabel)
    }
    func layoutTitleLabel() -> Void {
        titleLabel.frame.origin = CGPoint(x: 20, y: 10)
        titleLabel.sizeToFit()
    }
    
    //MinTempView
    func setupMinTemp() -> Void {
        minTemp.backgroundColor = UIColor.black
        addSubview(minTemp)
    }
    
    //MaxTempView
    func setupMaxTemp() -> Void {
        maxTemp.backgroundColor = UIColor.black
        addSubview(maxTemp)
    }
    
    //DescriptionLabel
    func setupDescriptionLabel() -> Void {
        minDescriptionLabel.text = "Min"
        minDescriptionLabel.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        minDescriptionLabel.textAlignment = .center
        addSubview(minDescriptionLabel)
        
        maxDescriptionLabel.text = "Max"
        maxDescriptionLabel.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        maxDescriptionLabel.textAlignment = .center
        addSubview(maxDescriptionLabel)
    }
    
    //TempLabel
    func setupTempLabel() -> Void {
        minTempLabel.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        minTempLabel.textAlignment = .center
        minTempLabel.formatString = "°"
        addSubview(minTempLabel)
        
        maxTempLabel.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        maxTempLabel.textAlignment = .center
        maxTempLabel.formatString = "°"
        addSubview(maxTempLabel)
    }
    
    func layoutDescriptionLabel() -> Void {
        minDescriptionLabel.frame = CGRect(x: bounds.width * 0.5 - 30 - 15, y: bounds.height * 0.5 + 20, width: 30, height: 12)
        maxDescriptionLabel.frame = CGRect(x: bounds.width * 0.5 + 15, y: bounds.height * 0.5 + 20, width: 30, height: 12)
    }
    
    //Line
    func setupLine() -> Void {
        line.backgroundColor = UIColor.black.cgColor
        layer.addSublayer(line)
    }
    func layoutLine() -> Void {
        line.frame = CGRect(x: 20, y: bounds.height * 0.5 + 10, width: bounds.width - 40, height: 1)
    }

}

extension TemperatureRangeView {
    func buildPresenter() {
        presenter = TemperatureRangePresenter.init()
        presenter?.attachView(view: self)
    }
    
    func renderingView(viewModel: Any) {
        let tuple = viewModel as! (Double,Double)
        let temp_min = Int(tuple.0)
        let temp_max = Int(tuple.1)

        minTemp.frame = CGRect(x: bounds.width * 0.5 - 30 - 15, y: bounds.height * 0.5 + 10, width: 30, height: 0)
        maxTemp.frame = CGRect(x: bounds.width * 0.5 + 15, y: bounds.height * 0.5 + 10, width: 30, height: 0)
        
        
        minTempLabel.frame = CGRect(x: bounds.width * 0.5 - 30 - 15, y: bounds.height * 0.5 + 10 - 12 - 5, width: 30, height: 12)
        maxTempLabel.frame = CGRect(x: bounds.width * 0.5 + 15, y: bounds.height * 0.5 + 10 - 12 - 5, width: 30, height: 12)
        
        UIView.animate(withDuration: 2) {
            self.minTemp.frame = CGRect(x: self.bounds.width * 0.5 - 45, y: self.bounds.height * 0.5 + 10 - CGFloat(temp_min), width: 30, height: CGFloat(temp_min))
            
            self.maxTemp.frame = CGRect(x: self.bounds.width * 0.5 + 15, y: self.bounds.height * 0.5 + 10 - CGFloat(temp_max), width: 30, height: CGFloat(temp_max))
            
            self.minTempLabel.frame = CGRect(x: self.bounds.width * 0.5 - 30 - 15, y: self.bounds.height * 0.5 + 10 - 12 - 5 - CGFloat(temp_min), width: 30, height: 12)
            self.maxTempLabel.frame = CGRect(x: self.bounds.width * 0.5 + 15, y: self.bounds.height * 0.5 + 10 - 12 - 5 - CGFloat(temp_max), width: 30, height: 12)
        }
        
        minTempLabel.count(from: 0, to: temp_min, duration: 2)
        maxTempLabel.count(from: 0, to: temp_max, duration: 2)
    }
    
    func eraseView() {
        minTempLabel.reset()
        maxTempLabel.reset()
        
    }
}
