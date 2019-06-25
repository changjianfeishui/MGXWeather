//
//  TemperaturePresenter.swift
//  MGXWeather
//
//  Created by Miu on 2019/4/29.
//  Copyright © 2019 MGX. All rights reserved.
//

import UIKit

class TemperaturePresenter: NSObject,ViewBindingProtocol {
    weak var view:ViewRenderingProtocol?
    //LifeCycle
    override init() {
        super.init()
        addNotifications()
    }
    deinit {
        deAttachView()
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: Event
    func addNotifications() -> Void {
        NotificationCenter.default.addObserver(self, selector: #selector(updateTemperature), name: Notification.Name.WeatherDataUpdateSuccess, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(weatherDataWillRefresh), name: Notification.Name.WeatherDataWillRefresh, object: nil)
    }
    @objc func updateTemperature() -> Void{
        let weatherData:Dictionary<String,Any> = WeatherDataCenter.weatherData!
        let main = weatherData["main"] as? Dictionary<String,Any>
        if let temp = main?["temp"] as? Double {
            view?.renderingView?(viewModel: Int(temp - 273.15))
        }
    }
    @objc func weatherDataWillRefresh() -> Void {
        view?.eraseView?()
    }
}


//MARK: ViewBinding
extension TemperaturePresenter {
    func attachView(view: ViewRenderingProtocol) {
        self.view = view
    }
    func deAttachView() {
        view = nil
    }
}
