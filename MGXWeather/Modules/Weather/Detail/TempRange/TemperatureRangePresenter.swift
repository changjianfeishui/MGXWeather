//
//  TemperatureRangePresenter.swift
//  MGXWeather
//
//  Created by Miu on 2019/4/30.
//  Copyright © 2019 MGX. All rights reserved.
//

import UIKit

class TemperatureRangePresenter: NSObject,ViewBindingProtocol {
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
        NotificationCenter.default.addObserver(self, selector: #selector(updateTempRange), name: Notification.Name.WeatherDataUpdateSuccess, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(weatherDataWillRefresh), name: Notification.Name.WeatherDataWillRefresh, object: nil)
    }
    @objc func updateTempRange() -> Void{
        let weatherData:Dictionary<String,Any> = WeatherDataCenter.weatherData!
        let main = weatherData["main"] as? Dictionary<String,Any>
        if let temp_min = main?["temp_min"] as? Double, let temp_max = main?["temp_max"] as? Double {
            view?.renderingView?(viewModel: (temp_min - 273.15,temp_max - 273.15))
        }
    }
    @objc func weatherDataWillRefresh() -> Void {
        view?.eraseView?()
    }
}

extension TemperatureRangePresenter {
    func attachView(view: ViewRenderingProtocol) {
        self.view = view
    }
    func deAttachView() {
        view = nil
    }
}
