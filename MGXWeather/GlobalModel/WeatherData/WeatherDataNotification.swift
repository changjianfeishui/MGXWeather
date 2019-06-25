//
//  WeatherDataNotification.swift
//  MGXWeather
//
//  Created by Miu on 2019/4/23.
//  Copyright © 2019 MGX. All rights reserved.
//

import UIKit
extension Notification.Name {
    public static let WeatherDataUpdateFailed = Notification.Name("WeatherDataUpdateFailedNotification")
    public static let WeatherDataUpdateSuccess = Notification.Name("WeatherDataUpdateSuccessNotification")
    
    public static let LocationCLGeocoderSuccess = Notification.Name("LocationCLGeocoderSuccess")
    
    public static let WeatherDataWillRefresh = Notification.Name("WeatherDataWillRefresh")
    
    public static let ForecastDataUpdateSuccess = Notification.Name("ForecastDataUpdateSuccess")
    
    public static let WeatherDataWillShow = Notification.Name("WeatherDataWillShow")
}


