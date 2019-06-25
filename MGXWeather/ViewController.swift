//
//  ViewController.swift
//  MGXWeather
//
//  Created by Miu on 2019/4/11.
//  Copyright © 2019 MGX. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let locMgr = LocationManager()
    let weatherView = WeatherView(frame: CGRect.zero)
    let loadingLayer = LoadingLayer.init()
    let blackLayer = CALayer()
    
    //MARK: LifeCycle
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addNotifications()
        setupWeatherView()
        setupLoadingLayer()
        setupBlackLayer()
        startLocation()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        weatherView.frame = view.safeAreaLayoutGuide.layoutFrame
        blackLayer.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        NotificationCenter.default.post(name: .WeatherDataWillShow, object: nil)
    }
    
    //MARK: SubViews
    func setupWeatherView() -> Void {
        weatherView.build()
        weatherView.topRefreshHandler = { [weak self] in
            self?.startLocation()
        }
        weatherView.bottomRefreshHandler = { [weak self] in
            let forecast = ForecastViewController()
            self?.present(forecast, animated: true, completion: nil)
        }
        view.addSubview(weatherView)
    }
    
    func setupLoadingLayer() -> Void {
        loadingLayer.dotCount = 15
        loadingLayer.dotColor = UIColor.orange.cgColor
        loadingLayer.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        loadingLayer.position = CGPoint(x: self.view.bounds.width * 0.5, y: self.view.bounds.height * 0.5)
        view.layer.addSublayer(loadingLayer)
    }
    
    func setupBlackLayer() -> Void {
        blackLayer.backgroundColor = UIColor.black.cgColor
        blackLayer.opacity = 0
        view.layer.addSublayer(blackLayer)
    }

    
    //Event
    func startLocation() -> Void {
        loadingLayer.start()
        blackLayer.opacity = 0.5
        NotificationCenter.default.post(name: .WeatherDataWillRefresh, object: nil)
        locMgr.start {[weak self] (location, error) in
            if error != nil {
                self?.handleLocationError()
            }else {
                WeatherDataCenter.weatherData(location: location!)
                WeatherDataCenter.forecastData(location: location!)
            }
        }
    }
    
    func addNotifications() -> Void {
        NotificationCenter.default.addObserver(self, selector: #selector(weatherDataUpdateSuccess), name: .WeatherDataUpdateSuccess, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showWeatherDataError(noti:)), name: .WeatherDataUpdateFailed, object: nil)
    }
    
    func endRefresh() -> Void {
        loadingLayer.stop()
        blackLayer.opacity = 0
    }
    
    @objc func weatherDataUpdateSuccess() -> Void {
        endRefresh()
    }

    
    @objc func showWeatherDataError(noti:Notification) -> Void {
        endRefresh()
        let error = noti.object as! NSError
        let alert = UIAlertController(title: "提示", message: error.localizedFailureReason, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alert.addAction(cancel)
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    
    func handleLocationError() -> Void {
        endRefresh()
        let alert = UIAlertController(title: "提示", message: "定位权限获取失败, 是否立即开启?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "下次再说", style: .cancel, handler: nil)
        let ok = UIAlertAction(title: "去设置", style: .default) { (_) in
            let url = URL(string: UIApplication.openSettingsURLString)
            if UIApplication.shared.canOpenURL(url!) {
                UIApplication.shared.open(url!, options: [UIApplication.OpenExternalURLOptionsKey.universalLinksOnly:false], completionHandler: nil)
            }
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}



