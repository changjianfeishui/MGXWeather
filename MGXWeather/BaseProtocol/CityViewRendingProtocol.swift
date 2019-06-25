//
//  CityViewRendingProtocol.swift
//  MGXWeather
//
//  Created by Miu on 2019/4/26.
//  Copyright © 2019 MGX. All rights reserved.
//

import Foundation
protocol CityViewRendingProtocol:ViewRenderingProtocol {
    func updateCityName(cityName:String?) -> Void
}
