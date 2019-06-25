//
//  ForecastCell.swift
//  MGXWeather
//
//  Created by Miu on 2019/5/28.
//  Copyright © 2019 MGX. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {
    
    var weatherInfo:Dictionary<String,Any>?
    let bottomLine = UIView(frame: .zero)
    let weekLabel = UILabel()
    let dateLabel = UILabel()
    let weatherDescriptionLabel = UILabel()
    let minTempLabel = UILabel()
    let maxTempLabel = UILabel()
    let weatherIconLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupBottomLine()
        setupWeekLabel()
        setupDateLabel()
        setupWeatherDescriptionLabel()
        setupMinTempLabel()
        setupMaxTempLabel()
        setupWeatherIconLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutBottomLine()
        layoutWeekLabel()
        layoutDateLabel()
        layoutWeatherDescriptionLabel()
        layoutMinTempLabel()
        layoutMaxTempLabel()
        layoutWeatherIconLabel()
    }
    
    //MinTemp
    func setupMinTempLabel() -> Void {
        minTempLabel.font = UIFont.systemFont(ofSize: 28, weight: .ultraLight)
        minTempLabel.textAlignment = .left
        addSubview(minTempLabel)
    }
    func layoutMinTempLabel() -> Void {
        minTempLabel.frame = CGRect(x: weekLabel.frame.maxX + 20, y: 0, width: 55, height: bounds.height)
    }
    
    //MaxTemp
    func setupMaxTempLabel() -> Void {
        maxTempLabel.font = UIFont.systemFont(ofSize: 28, weight: .ultraLight)
        maxTempLabel.textAlignment = .left
        addSubview(maxTempLabel)
    }
    func layoutMaxTempLabel() -> Void {
        maxTempLabel.frame = CGRect(x: minTempLabel.frame.maxX + 20, y: 0, width: 55, height: bounds.height)
    }
    
    //WeatherIcon
    func setupWeatherIconLabel() ->  Void{
        weatherIconLabel.font = UIFont(name: "Weather&Time", size: 40)
        addSubview(weatherIconLabel)
    }
    func layoutWeatherIconLabel() -> Void {
        let w:CGFloat = 60
        weatherIconLabel.frame = CGRect(x: maxTempLabel.frame.maxX + 20, y: 0, width: w, height: bounds.height)
    }
    
    //WeatherDescription
    func setupWeatherDescriptionLabel() -> Void {
        weatherDescriptionLabel.font = UIFont.systemFont(ofSize: 10, weight: .light)
        weatherDescriptionLabel.textAlignment = .left
        addSubview(weatherDescriptionLabel)
    }
    func layoutWeatherDescriptionLabel() -> Void {
        weatherDescriptionLabel.frame = CGRect(x: 5, y: 5, width: bounds.width - 100, height: 10)
    }
    
    //Date
    func setupDateLabel() -> Void {
        dateLabel.font = UIFont.systemFont(ofSize: 8, weight: .ultraLight)
        dateLabel.textAlignment = .right
        addSubview(dateLabel)
    }
    func layoutDateLabel() -> Void {
        let width:CGFloat = 100
        dateLabel.frame = CGRect(x: bounds.width - width - 5, y: 5, width: width, height: 10)
    }
    
    
    //Week
    func setupWeekLabel() -> Void {
        weekLabel.font = UIFont.systemFont(ofSize: 28, weight: .ultraLight)
        weekLabel.textAlignment = .left
        addSubview(weekLabel)
    }
    func layoutWeekLabel() -> Void {
        weekLabel.frame = CGRect(x: 10, y: 0, width: 70, height: bounds.height)
    }

    
    //Line
    func setupBottomLine() -> Void {
        bottomLine.backgroundColor = UIColor(white: 0, alpha: 0.1)
        contentView.addSubview(bottomLine)
    }
    func layoutBottomLine() -> Void {
        bottomLine.frame = CGRect(x: 0, y: bounds.height - 0.5, width: bounds.width, height: 0.5)
    }
    
    //MARK: DataRending
    public func config(weather:Dictionary<String,Any>) {
        weatherInfo = weather
        rendingDate()
        rendingWeatherDescription()
        rendingTemp()
        rendingWeatherIcon()
    }
    
    func rendingWeatherIcon() -> Void {
        guard weatherInfo != nil else {
            return
        }
        let weather = (weatherInfo!["weather"] as? Array<Dictionary<String, Any>>)?.first
        let weatherID:Int = weather?["id"] as! Int
        weatherIconLabel.text = WeatherDataCenter.weatherText(withWeatherID: weatherID)
    }
    
    func rendingTemp() -> Void {
        guard weatherInfo != nil else {
            return
        }
        let temp = weatherInfo!["temp"] as? Dictionary<String,Any>
        let min = Int(temp?["min"] as! Double - 273.15)
        let max = Int(temp?["max"] as! Double - 273.15)
        minTempLabel.text = "\(min)°"
        maxTempLabel.text = "\(max)°"
//        minTempLabel.backgroundColor = UIColor.green
//        maxTempLabel.backgroundColor = UIColor.red
    }
    
    func rendingWeatherDescription() -> Void {
        guard weatherInfo != nil else {
            return
        }
        let weather = (weatherInfo!["weather"] as? Array<Dictionary<String, Any>>)?.first
        weatherDescriptionLabel.text = (weather?["description"] as? String)
    }
    
    func rendingDate() -> Void {
        guard weatherInfo != nil else {
            return
        }
        if let dt:Int = weatherInfo!["dt"] as? Int{
            let date = Date(timeIntervalSince1970: TimeInterval(dt))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd"
            dateLabel.text = dateFormatter.string(from: date)
            
            dateFormatter.dateFormat = "EEE"
            weekLabel.text = dateFormatter.string(from: date)
            if weekLabel.text == "Sun" {
                weekLabel.textColor = UIColor.red
            }else {
                weekLabel.textColor = UIColor.black
            }
        }
        
        
    }
}
