//
//  WeatherIconPresenter.swift
//  MGXWeather
//
//  Created by Miu on 2019/4/26.
//  Copyright © 2019 MGX. All rights reserved.
//

import UIKit

class WeatherIconPresenter: NSObject,ViewBindingProtocol {
    
    weak var view:ViewRenderingProtocol?

    //MARK: ViewBinding
    func attachView(view: ViewRenderingProtocol) {
        self.view = view
    }
    func deAttachView() {
        view = nil
    }
    
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
        NotificationCenter.default.addObserver(self, selector: #selector(updateWeatherIcon), name: Notification.Name.WeatherDataUpdateSuccess, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(weatherDataWillRefresh), name: Notification.Name.WeatherDataWillRefresh, object: nil)
    }
    @objc func updateWeatherIcon() -> Void{
        let weatherData:Dictionary<String,Any> = WeatherDataCenter.weatherData!
        let weatherArray = weatherData["weather"] as? Array<[String:Any]>
        let weaterDescription = weatherArray?.first
        if let weatherID = weaterDescription?["id"] as? Int {
            let weatherString = WeatherDataCenter.weatherText(withWeatherID: weatherID)
            view?.renderingView?(viewModel: weatherString)
        }
    }
    
    @objc func weatherDataWillRefresh() -> Void {
        view?.eraseView?()
    }
    
    
    
    
}
