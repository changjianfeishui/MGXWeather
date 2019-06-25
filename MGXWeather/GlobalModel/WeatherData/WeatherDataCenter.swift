//
//  WeatherDataCenter.swift
//  MGXWeather
//
//  Created by Miu on 2019/4/22.
//  Copyright © 2019 MGX. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherDataCenter: NSObject {
    
    static public var weatherData:Dictionary<String,Any>? = nil
    static public var forecastData:Dictionary<String,Any>? = nil
    static public var forecastList:Array<Dictionary<String,Any>>? = nil
    
    static public func weatherData(location:CLLocation) {
        let lon = location.coordinate.longitude
        let lat = location.coordinate.latitude
        let params:[String : Any] = ["lon":lon,"lat":lat,"APPID":"979897a63139fb4ffcd5f851786f401e"]
        AF.request("https://api.openweathermap.org/data/2.5/weather", method: .get, parameters: params).responseJSON { (response) in
            guard response.response?.statusCode == 200 else {
                let err = NSError(domain: "WeatherDataCenter", code: response.response?.statusCode ?? 0, userInfo: [NSLocalizedFailureReasonErrorKey:"数据获取失败, 请检查网络"])
                NotificationCenter.default.post(name: .WeatherDataUpdateFailed, object: err)
                return
            }
            if let json:Dictionary<String,Any> = response.result.value as? Dictionary<String, Any> {
                guard json["cod"] as! Int == 200 else {
                    let err = NSError(domain: "WeatherDataCenter", code: json["error_code"] as! Int, userInfo: [NSLocalizedFailureReasonErrorKey:"服务器出差了, 请稍后再试"])
                    NotificationCenter.default.post(name: .WeatherDataUpdateFailed, object: err)
                    return
                }
            }
            weatherData = response.result.value as? Dictionary<String,Any>
            NotificationCenter.default.post(name: .WeatherDataUpdateSuccess, object: nil)

        }
    }
    
    static public func forecastData(location:CLLocation) {
        let lon = location.coordinate.longitude
        let lat = location.coordinate.latitude
        let params:[String : Any] = ["lon":lon,"lat":lat,"APPID":"8c0e04b52e6da9e67c51a102d6269a60","cnt":16]
        AF.request("https://api.openweathermap.org/data/2.5/forecast/daily", method: .get, parameters: params).responseJSON { (response) in
            guard response.response?.statusCode == 200 else {
                return
            }
            forecastData = response.result.value as? Dictionary<String,Any>
            forecastList = forecastData?["list"] as? Array<Dictionary<String, Any>>
            NotificationCenter.default.post(name: .ForecastDataUpdateSuccess, object: nil)

        }
    }
    
    static func weatherText(withWeatherID weatherId:Int) -> String {
        var weatherText:String
        switch (weatherId) {
        case 900:
            weatherText = "e";
        case 901,902:
            weatherText = "Y";
        case 903:
            weatherText = "o";
        case 904:
            weatherText = "h";
        case 905:
            weatherText = "a";
        case 906:
            weatherText = "W";
        case 951:
            weatherText = "B";
        case 952...957:
            weatherText = "Z";
        case 958...962:
            weatherText = "Y";
        // Thunderstorm
        case 210,211,212,221:
            weatherText = "T";
        case 200,201,202,230,231,232:
            weatherText = "V";
        // Drizzle
        case 300,301,302,311,312,313,314,321:
            weatherText = "R";
        // Rain
        case 500:
            weatherText = "R";
        case 501...504:
            weatherText = "S";
        case 511,520,521,522,531:
            weatherText = "X";
        // Snow
        case 600...699:
            weatherText = "W";
        // Atmosphere
        case 701:
            weatherText = "N";
        case 711,721,731,741:
            weatherText = "G";
        case 751,761,762,771:
            weatherText = "O";
        case 781:
            weatherText = "e";
        // Clouds
        case 800:
            weatherText = "A";
        case 801:
            weatherText = "C";
        case 802...804:
            weatherText = "D";
        default:
            // 未知的情况
            weatherText = "p";
        }
        return weatherText
    }
}


