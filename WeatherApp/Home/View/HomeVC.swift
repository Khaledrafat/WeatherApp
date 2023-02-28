//
//  HomeVC.swift
//  WeatherApp
//
//  Created by mac on 26/02/2023.
//

import UIKit

class HomeVC: UIViewController , HomeVC_PR {
    
    @IBOutlet weak var weatherLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    
    var presenter: HomePresenter_PR!

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = HomePresenter(view: self)
        self.locationLbl.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(weatherReceived), name: NSNotification.Name("Weather"), object: nil)
    }
    
    // MARK: - Receive Weather Data
    @objc func weatherReceived(_ notification: NSNotification) {
        if let weather = notification.userInfo?["weather"] as? WeatherModel_PR {
            self.weatherLbl.text = weather.weatherC_Temp + " °C"
            if let location = weather.weatherCity {
                self.locationLbl.isHidden = false
                if let type = weather.weatherType {
                    self.locationLbl.text = type == .forecast ? "Forecast Degree For: \n \(location)" : "Current Degree For: \n \(location)"
                } else {
                    self.locationLbl.text = location
                }
            }
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
        NotificationCenter.default.removeObserver(self)
    }

}
