//
//  CityViewPresenter.swift
//  MGXWeather
//
//  Created by Miu on 2019/4/25.
//  Copyright © 2019 MGX. All rights reserved.
//

import UIKit

class CityViewPresenter: NSObject,ViewBindingProtocol {
    
    weak var view:CityViewRendingProtocol?
    
    //MARK: ViewBinding
    func attachView(view: ViewRenderingProtocol) {
        self.view = view as? CityViewRendingProtocol
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
        NotificationCenter.default.addObserver(self, selector: #selector(updateCityData), name: Notification.Name.WeatherDataUpdateSuccess, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateCityName), name: Notification.Name.LocationCLGeocoderSuccess, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(weatherDataWillRefresh), name: Notification.Name.WeatherDataWillRefresh, object: nil)

    }
    
    @objc func updateCityData() -> Void{
        let weatherData = WeatherDataCenter.weatherData
        view?.renderingView?(viewModel: weatherData!)
    }
    
    @objc func updateCityName(noti:Notification) -> Void{
        let cityName = noti.object as? String
        view?.updateCityName(cityName: cityName)
    }
    
    @objc func weatherDataWillRefresh() -> Void {
        view?.eraseView?()
    }
    
}


