//
//  WindSpeedPresenter.swift
//  MGXWeather
//
//  Created by Miu on 2019/5/6.
//  Copyright © 2019 MGX. All rights reserved.
//

import UIKit

class WindSpeedPresenter: NSObject,ViewBindingProtocol {
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
        let wind = weatherData["wind"] as? Dictionary<String,Any>
        if let speed = wind?["speed"] as? Double {
            view?.renderingView?(viewModel: speed)
        }
    }
    @objc func weatherDataWillRefresh() -> Void {
        view?.eraseView?()
    }
}

extension WindSpeedPresenter {
    func attachView(view: ViewRenderingProtocol) {
        self.view = view
    }
    func deAttachView() {
        view = nil
    }
}
