//
//  WindSpeedView.swift
//  MGXWeather
//
//  Created by Miu on 2019/5/6.
//  Copyright © 2019 MGX. All rights reserved.
//

import UIKit

class WindSpeedView: UIView,ViewRenderingProtocol {
    
    let titleLabel = UILabel()
    let vane = VaneLayer()
    let shaft = CALayer()
    let windLabel = UILabel()
    
    public func build() -> Void {
        setupTitleLabel()
        setupVane()
        setupShaft()
        setupWindLabel()
        buildPresenter()
    }
    
    //MARK: SubViews
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutTitleLabel()
        layoutVane()
        layoutShaft()
        layoutWindLabel()
    }
    
    //Title
    func setupTitleLabel() -> Void {
        titleLabel.text = "Wind Speed"
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.light)
        addSubview(titleLabel)
    }
    func layoutTitleLabel() -> Void {
        titleLabel.frame.origin = CGPoint(x: 20, y: 10)
        titleLabel.sizeToFit()
    }
    
    //Vane
    func setupVane() -> Void {
        vane.build()
        layer.addSublayer(vane)
    }
    func layoutVane() -> Void {
        vane.frame = CGRect(x: 40, y: 40, width: 60, height: 60)
    }
    
    //Shaft
    func setupShaft() -> Void {
        shaft.backgroundColor = UIColor.black.cgColor
        layer.addSublayer(shaft)
    }
    func layoutShaft() -> Void {
        shaft.frame = CGRect(x: 69.5, y: 75, width: 2, height: bounds.size.height - 120)
    }
    
    //WindLabel
    func setupWindLabel() -> Void {
        windLabel.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        windLabel.textColor = UIColor.black
        addSubview(windLabel)
    }
    func layoutWindLabel() -> Void {
        windLabel.frame = CGRect(x: 90, y: shaft.frame.maxY - 12, width: 50, height: 12)
    }

}

extension WindSpeedView {
    func buildPresenter() {
        presenter = WindSpeedPresenter.init()
        presenter?.attachView(view: self)
    }
    
    func renderingView(viewModel: Any) {
        let windSpeed:Double = viewModel as! Double
        let attributeString = NSMutableAttributedString(string: "\(windSpeed)",attributes: [.foregroundColor:UIColor.black,.font:UIFont.systemFont(ofSize: 12, weight: .semibold)])
        let unit = NSAttributedString(string: " mps", attributes: [.foregroundColor:UIColor.lightGray,.font:UIFont.systemFont(ofSize: 10, weight: .light)])
        attributeString.append(unit)
        
        windLabel.attributedText = attributeString
        //默认最大风速为50
        var duration:CFTimeInterval = (50 - windSpeed)/10
        if duration < 0 {
            duration = 1
        }
        vane.showAnimation(duration: duration)
    }
    
    func eraseView() {
        vane.removeAllAnimations()
    }
}
