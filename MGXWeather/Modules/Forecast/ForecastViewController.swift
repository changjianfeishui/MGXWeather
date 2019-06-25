//
//  ForecastViewController.swift
//  MGXWeather
//
//  Created by Miu on 2019/5/28.
//  Copyright © 2019 MGX. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: UITableView.Style.plain)
    private let cellReuseIdentifier = "forecast"
    private let refreshView = ArrowRefreshView(frame: .zero)
    
    public var forecastList:Array<Dictionary<String,Any>>? = nil

    
    //MARK: LifeCycle
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupTableView()
        setupRefreshView()
        addNotifications()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.showForecast()
        }

    }
    
    //MARK: Event
    func addNotifications() -> Void {
        NotificationCenter.default.addObserver(self, selector: #selector(forecastDataUpdateSuccess), name: .ForecastDataUpdateSuccess, object: nil)
    }
    
    @objc func forecastDataUpdateSuccess() -> Void {
        self.showForecast()

    }
    
    func showForecast() -> Void {
        forecastList = WeatherDataCenter.forecastList
        tableView.reloadData()
        let visibleCells = tableView.visibleCells
        for (index,cell) in visibleCells.enumerated() {
            cell.transform = CGAffineTransform(translationX: tableView.bounds.width, y: 0)
            let delay = Double(index) * (0.2 / Double(visibleCells.count))
            UIView.animate(withDuration: 0.75, delay: delay, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveLinear, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
        }
    }
    
    //MARK: Subviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.safeAreaLayoutGuide.layoutFrame
        refreshView.bounds = CGRect(x: 0, y: 0, width: 30, height: 10)
        refreshView.center = CGPoint(x: tableView.bounds.width * 0.5, y: -15)
    }
    
    func setupTableView() -> Void {
        tableView.register(ForecastCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.rowHeight = 100
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        view.addSubview(tableView)
    }
    
    func setupRefreshView() -> Void {
        refreshView.build()
        refreshView.direction = .down
        tableView.addSubview(refreshView)
    }
    
   
}


extension ForecastViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! ForecastCell
        let weather = forecastList![indexPath.row]
        cell.config(weather: weather)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Weather Forecast"
    }
}


extension ForecastViewController:UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            let topPercent = (-scrollView.contentOffset.y)/60
            refreshView.animation(percent: topPercent)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y <= -60 {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
