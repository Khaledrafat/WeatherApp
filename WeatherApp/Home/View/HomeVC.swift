//
//  HomeVC.swift
//  WeatherApp
//
//  Created by mac on 26/02/2023.
//

import UIKit

class HomeVC: UIViewController{
    
    @IBOutlet weak var weatherLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    
    private var presenter: HomePresenterPR!
    private var notification : notificationCenterPR? = NotificationCenter.default
    
    // MARK: - For Unit Test
    convenience init(notification : notificationCenterPR = NotificationCenter.default) {
        self.init()
        self.notification = notification
    }

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = HomePresenter()
        self.locationLbl.isHidden = true
        self.setupObserver()
    }
    
    // MARK: - Setup NotificationCenter Observer
    private func setupObserver() {
        notification?.addObserver(self, selector: #selector(weatherReceived), name: NSNotification.Name("Weather"), object: nil)
    }
    
    // MARK: - Receive Weather Data
    @objc func weatherReceived(_ notification: NSNotification) {
        guard let weather = notification.userInfo?["weather"] as? WeatherModelPR else { return }
        self.weatherLbl.text = weather.weatherC_Temp + " °C"
        guard let location = weather.weatherCity else { return }
        self.locationLbl.isHidden = false
        if let type = weather.weatherType {
            self.locationLbl.text = type == .forecast ? "Forecast Degree For: \n \(location)" : "Current Degree For: \n \(location)"
        } else {
            self.locationLbl.text = location
        }
    }
    
    // MARK: - navigate TO VC
    @IBAction func navigateToVCButton(_ sender: UIButton) {
        let type: WeatherType = sender.tag == 0 ? .current : .forecast
        let vc = presenter.openWeatherVC(type: type)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Deinit
    deinit {
        notification?.removeObserver(self)
    }

}
