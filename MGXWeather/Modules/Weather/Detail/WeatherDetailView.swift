//
//  WeatherDetailView.swift
//  MGXWeather
//
//  Created by Miu on 2019/4/23.
//  Copyright © 2019 MGX. All rights reserved.
//

import UIKit

class WeatherDetailView: UIView {

    var horLines = [CALayer]()
    let verLine = CALayer.init()
    
    let weatherIcon = WeatherIconView()
    let temperature = TemperatureView()
    let humidity = HumidityView()
    let sun = SunInfoView()
    let tempRange = TemperatureRangeView()
    let windSpeed = WindSpeedView()
    
    public func build() -> Void {
        setupLines()
        setupWeatherIcon()
        setupTemperatureView()
        setupHumidityView()
        setupSunInfoView()
        setupTempRange()
        setupWindSpeedView()
    }
    
    //MARK: SubViews
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutLines()
        layoutWeatherIcon()
        layoutTemperatureView()
        layoutHumidityView()
        layoutSunInfoView()
        layoutTempRange()
        layoutWindSpeedView()
    }
    
    //WeatherIcon
    func setupWeatherIcon() -> Void {
        weatherIcon.build()
        addSubview(weatherIcon)
    }
    func layoutWeatherIcon() -> Void {
        let height:CGFloat = bounds.height/3
        let width:CGFloat = bounds.width/2
        weatherIcon.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }
    
    //Temperature
    func setupTemperatureView() -> Void {
        temperature.build()
        addSubview(temperature)
    }
    func layoutTemperatureView() -> Void {
        let height:CGFloat = bounds.height/3
        let width:CGFloat = bounds.width/2
        temperature.frame = CGRect(x: width, y: 0, width: width, height: height)
    }
    
    //Humidity
    func setupHumidityView() -> Void {
        humidity.build()
        addSubview(humidity)
    }
    func layoutHumidityView() -> Void {
        let height:CGFloat = bounds.height/3
        let width:CGFloat = bounds.width/2
        humidity.frame = CGRect(x: 0, y: height, width: width, height: height)
    }
    
    //Sun
    func setupSunInfoView() -> Void {
        sun.build()
        addSubview(sun)
    }
    func layoutSunInfoView() -> Void {
        let height:CGFloat = bounds.height/3
        let width:CGFloat = bounds.width/2
        sun.frame = CGRect(x: width, y: height, width: width, height: height)
    }
    
    //Temp Range
    func setupTempRange() -> Void {
        tempRange.build()
        addSubview(tempRange)
    }
    func layoutTempRange() -> Void {
        let height:CGFloat = bounds.height/3
        let width:CGFloat = bounds.width/2
        tempRange.frame = CGRect(x: 0, y: height * 2, width: width, height: height)
    }
    
    //WindSpeed
    func setupWindSpeedView() -> Void {
        windSpeed.build()
        addSubview(windSpeed)
    }
    func layoutWindSpeedView() -> Void {
        let height:CGFloat = bounds.height/3
        let width:CGFloat = bounds.width/2
        windSpeed.frame = CGRect(x: width, y: height * 2, width: width, height: height)
    }
    
    //分割线
    func setupLines() -> Void {
        for _ in 0...3 {
            let horLine = CALayer.init()
            horLine.backgroundColor = UIColor(white: 0, alpha: 0.1).cgColor
            layer.addSublayer(horLine)
            horLines.append(horLine)
        }
        verLine.backgroundColor = UIColor(white: 0, alpha: 0.1).cgColor
        layer.addSublayer(verLine)
    }
    func layoutLines() -> Void {
        let gap:CGFloat = bounds.height/3
        for index in 0..<horLines.count {
            let horLine = horLines[index]
            horLine.frame = CGRect(x: 0, y: gap * CGFloat(index) - 1, width: bounds.width, height: 0.5)
        }
        verLine.frame = CGRect(x: bounds.width * 0.5, y: 0, width: 0.5, height: bounds.height)
    }
    
    

}
