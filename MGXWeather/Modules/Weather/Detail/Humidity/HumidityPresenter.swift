//
//  HumidityPresenter.swift
//  MGXWeather
//
//  Created by Miu on 2019/4/29.
//  Copyright © 2019 MGX. All rights reserved.
//

import UIKit

class HumidityPresenter: NSObject,ViewBindingProtocol {
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
        NotificationCenter.default.addObserver(self, selector: #selector(updateHumidity), name: Notification.Name.WeatherDataUpdateSuccess, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(weatherDataWillRefresh), name: Notification.Name.WeatherDataWillRefresh, object: nil)
    }
    @objc func updateHumidity() -> Void{
        let weatherData:Dictionary<String,Any> = WeatherDataCenter.weatherData!
        let main = weatherData["main"] as? Dictionary<String,Any>
        if let humidity = main?["humidity"] as? Double {
            view?.renderingView?(viewModel: Int(humidity))
        }
    }
    
    @objc func weatherDataWillRefresh() -> Void {
        view?.eraseView?()
    }
}

extension HumidityPresenter {
    func attachView(view: ViewRenderingProtocol) {
        self.view = view
    }
    func deAttachView() {
        view = nil
    }
}
