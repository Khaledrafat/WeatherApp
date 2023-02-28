//
//  ForecastVC+Delegation.swift
//  WeatherApp
//
//  Created by mac on 26/02/2023.
//

import UIKit

extension WeatherVC: WeatherVCPR{
    // MARK: - Start Loading
    func startLoading() {
        DispatchQueue.main.async {[weak self] in
            guard let self = self else { return }
            self.startSpinning()
        }
    }
    
    // MARK: - EndLoading
    func endLoading() {
        DispatchQueue.main.async {[weak self] in
            guard let self = self else { return }
            self.endSpinning()
        }
    }
    
    // MARK: - Failed Request Message
    func requestFailedWith(message: String) {
        self.showFailureAlert(message)
    }
    
    func weatherFetchedSucessfully(weather: WeatherModelPR) {
        let weatherData = ["weather" : weather]
        NotificationCenter.default.post(name: NSNotification.Name("Weather"), object: nil, userInfo: weatherData)
        let degreeType = self.screenType == .forecast ? " °C" : Constants.degreeType.degree
        var degree = ""
        if self.screenType == .forecast {
            degree = weather.weatherC_Temp
        } else {
            degree = Constants.degreeType == .C ? weather.weatherC_Temp : weather.weatherF_Temp.emptyString
        }
        self.degreeLbl.text = degree + degreeType
        if let location = weather.weatherCity {
            self.cityLbl.text = location
        }
        guard self.cityLbl.isHidden == true else { return }
        UIView.animate(withDuration: 0.4) { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.cityLbl.isHidden = false
                self.getForcastBtn.isHidden = self.screenType == .forecast
            }
        }
    }
    
    // MARK: - Wrong Location Format
    func wrongLocationFormat() {
        self.showFailureAlert("Wrong Format \n Please Enter Right one")
    }
    
    // MARK: - Degree Type Changed
    func degreeTypeChanged(weather: WeatherModelPR?) {
        if let weather = weather {
            let degreeType = Constants.degreeType.degree
            let degree = Constants.degreeType == .C ? weather.weatherC_Temp : weather.weatherF_Temp.emptyString
            self.degreeLbl.text = degree + degreeType
        }
    }
    
    // MARK: - Reload Data
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.historyTable.reloadData()
        }
    }
}
