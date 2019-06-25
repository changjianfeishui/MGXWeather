//
//  SunPresenter.swift
//  MGXWeather
//
//  Created by Miu on 2019/4/30.
//  Copyright © 2019 MGX. All rights reserved.
//

import UIKit

class SunPresenter: NSObject,ViewBindingProtocol {
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
        NotificationCenter.default.addObserver(self, selector: #selector(updateSunInfo), name: Notification.Name.WeatherDataUpdateSuccess, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(weatherDataWillRefresh), name: Notification.Name.WeatherDataWillRefresh, object: nil)

    }
    @objc func updateSunInfo() -> Void{
        let weatherData:Dictionary<String,Any> = WeatherDataCenter.weatherData!
        let sys = weatherData["sys"] as! Dictionary<String,Any>
        if let sunrise = sys["sunrise"] as? Double, let sunset = sys["sunset"] as? Double {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:MM"
            let sunriseDate = Date(timeIntervalSince1970: sunrise)
            let sunsetDate = Date(timeIntervalSince1970: sunset)
            view?.renderingView?(viewModel: (formatter.string(from: sunriseDate),formatter.string(from: sunsetDate)))
        }
    }
    
    @objc func weatherDataWillRefresh() -> Void {
        view?.eraseView?()
    }
}

extension SunPresenter {
    func attachView(view: ViewRenderingProtocol) {
        self.view = view
    }
    func deAttachView() {
        view = nil
    }
}
