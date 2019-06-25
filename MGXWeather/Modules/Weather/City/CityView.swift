//
//  CityView.swift
//  MGXWeather
//
//  Created by Miu on 2019/4/22.
//  Copyright © 2019 MGX. All rights reserved.
//

import UIKit

class CityView: UIView,CityViewRendingProtocol {
    internal let leftView = CAShapeLayer.init()
    let cityLabel = UILabel(frame: CGRect.zero)
    let weatherLabel = UILabel(frame: CGRect.zero)
    let updataTimeLabel = UILabel(frame: .zero)
    let emitterLayer = CAEmitterLayer.init()
    public func build() -> Void {
        setupLeftView()
        setupCityLabel()
        setupWeatherLabel()
        setupUpdataTimeLabel()
        setupEmitterLayer()
        buildPresenter()
    }
    
    //MARK: SubViews
    override func layoutSubviews() {
        super.layoutSubviews()
        let gap: CGFloat = 10
        let leftHeight:CGFloat = bounds.height * 0.65
        let leftWidth:CGFloat = 5
        leftView.frame = CGRect(x: 0, y: (bounds.height - leftHeight) * 0.5, width: leftWidth, height: leftHeight)
        cityLabel.frame = CGRect(x: gap, y: leftView.frame.minY, width: bounds.width, height: cityLabel.font.lineHeight)
        weatherLabel.frame = CGRect(x: gap, y: leftView.frame.maxY - weatherLabel.font.lineHeight, width: bounds.width, height: weatherLabel.font.lineHeight)
        
        let rightWidth:CGFloat = 150
        updataTimeLabel.frame = CGRect(x: bounds.width - rightWidth, y: leftView.frame.minY, width: rightWidth, height: leftHeight)
      
    }
    
    func setupLeftView() -> Void {
        leftView.backgroundColor = UIColor.black.cgColor
        layer.addSublayer(leftView)
    }
    
    func setupCityLabel() -> Void {
        cityLabel.text = ""
        cityLabel.font = UIFont.systemFont(ofSize: 30)
        addSubview(cityLabel)
    }
    
    func setupWeatherLabel() -> Void {
        weatherLabel.text = ""
        weatherLabel.font = UIFont.systemFont(ofSize: 14)
        weatherLabel.textColor = UIColor(red: 138/255.0, green: 138/255.0, blue: 138/255.0, alpha: 1)
        addSubview(weatherLabel)
    }
    
    func setupUpdataTimeLabel() -> Void {
        updataTimeLabel.textColor = UIColor.white
        updataTimeLabel.textAlignment = .center
        updataTimeLabel.font = UIFont.systemFont(ofSize: 16)
        updataTimeLabel.numberOfLines = 0
        updataTimeLabel.backgroundColor = UIColor.red
        addSubview(updataTimeLabel)
    }
    
    func setupEmitterLayer() -> Void {
        emitterLayer.emitterShape = .line
        emitterLayer.emitterMode = .outline
        emitterLayer.renderMode = .oldestFirst
        emitterLayer.birthRate = 0
        emitterLayer.emitterSize = CGSize(width: UIScreen.main.bounds.width, height: 0)
        emitterLayer.emitterPosition = CGPoint(x: UIScreen.main.bounds.midX, y: 0)
        
        layer.addSublayer(emitterLayer)
        
        let rainCell = CAEmitterCell.init()
        rainCell.contents = UIImage.init(named: "rain")?.cgImage
        
        rainCell.scale = 0.2
        rainCell.scaleRange = 0.05
        
        rainCell.birthRate = 10
        rainCell.lifetime = 5
        rainCell.velocity = 500
        rainCell.velocityRange = 50
        rainCell.emissionLongitude = CGFloat.pi
        emitterLayer.emitterCells = [rainCell]
    }
}

//MARK: CityViewRendingProtocol
extension CityView {
    
    func buildPresenter() {
        presenter = CityViewPresenter.init()
        presenter?.attachView(view: self)
    }
    
    func renderingView(viewModel: Any) {
        let weatherData:Dictionary<String,Any> = viewModel as! Dictionary<String,Any>
        
        let weatherArray = weatherData["weather"] as? Array<[String:Any]>
        let weaterDescription = weatherArray?.first
        
        weatherLabel.text = weaterDescription?["description"] as? String
        
        //雨雪效果
        if let weatherID = weaterDescription?["id"] as? Int {
            let weatherIDStr = String(weatherID)
            if ["2","3","5","6"].contains(weatherIDStr.first) {
                emitterLayer.birthRate = 1
            }
        }

        //更新日期
        let calender = Calendar.init(identifier: .gregorian)
        let dateComponentUnitSet = Set<Calendar.Component>([.year,.month,.day,.hour,.minute,.weekday])
        let dateComponent = calender.dateComponents(dateComponentUnitSet, from: Date())
        
        let year = "\(dateComponent.year!)."
        let month = "\(dateComponent.month!)."
        let day = "\(dateComponent.day!)"
        let week = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday",]
        let weekDay = week[dateComponent.weekday! - 1]
        let hour = String(format: "%02d",dateComponent.hour!)
        let minute = String(format: "%02d", dateComponent.minute!)
        let time = "\(hour):\(minute)"
        updataTimeLabel.text = year + month + day + "\n" + weekDay + "\n" + time + " update"
    }
    
    func updateCityName(cityName: String?) {
        cityLabel.text = cityName
    }

    func eraseView() {
        cityLabel.text = nil
        updataTimeLabel.text = nil
        weatherLabel.text = nil
        emitterLayer.birthRate = 0
    }
    
}

