//
//  WeatherView.swift
//  MGXWeather
//
//  Created by Miu on 2019/4/22.
//  Copyright © 2019 MGX. All rights reserved.
//

import UIKit

class WeatherView: UITableView {
    
    let city = CityView(frame: CGRect.zero)
    let weatherDetail = WeatherDetailView(frame: .zero)
    let topRefreshView = TopRefreshView(frame: CGRect(x: 0, y: -60, width: UIScreen.main.bounds.width, height: 60))
    let bottomRefreshView = ArrowRefreshView(frame: CGRect(x: 0, y: 0, width: 30, height: 10))
    
    var topRefreshHandler:(() -> Void)?
    var bottomRefreshHandler:(() -> Void)?

    public func build() -> Void {
        separatorStyle = .none
        setupCityView()
        setupWeatherDetailView()
        setupTopRefreshView()
        setupBottomRefreshView()
        delegate = self
    }
    
    //MARK: SubViews
    override func layoutSubviews() {
        super.layoutSubviews()
        let cityHeight:CGFloat = 100
        city.frame = CGRect(x: 0, y: 0, width: bounds.width, height: cityHeight)
        weatherDetail.frame = CGRect(x: 0, y: cityHeight, width: bounds.width, height: bounds.height - cityHeight)
        bottomRefreshView.center = CGPoint(x: frame.midX, y: bounds.height + 20)
    }
    
    func setupCityView() -> Void {
        city.build()
        addSubview(city)
    }
    
    func setupWeatherDetailView() -> Void {
        weatherDetail.build()
        addSubview(weatherDetail)
    }
    
    func setupTopRefreshView() -> Void {
        topRefreshView.build()
        addSubview(topRefreshView)
    }
    
    func setupBottomRefreshView() -> Void {
        bottomRefreshView.build()
        addSubview(bottomRefreshView)
    }
}


extension WeatherView: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y < 0 {
            let topPercent = (-scrollView.contentOffset.y)/60
            topRefreshView.animation(percent: topPercent)
        } else {
            let bottomPercent = scrollView.contentOffset.y/60
            bottomRefreshView.animation(percent: bottomPercent)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y <= -60 && topRefreshHandler != nil {
            topRefreshHandler!()
        }
        
        if scrollView.contentOffset.y >= 60 && bottomRefreshHandler != nil {
            bottomRefreshHandler!()
        }
    }
}
