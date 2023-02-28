//
//  HomePresenter.swift
//  WeatherApp
//
//  Created by mac on 26/02/2023.
//

import Foundation
import UIKit

final class HomePresenter: HomePresenter_PR {
    
    private var view: HomeVC_PR!
    
    init(view: HomeVC_PR) {
        self.view = view
    }
    
    // MARK: - Open Forecast VC
    func openWeatherVC(type: WeatherType) -> WeatherVC {
        let vc = WeatherVC()
        vc.screenType = type
        if type == .forecast {
            let presenter = WeatherPresenter(view: vc, interactor: ForecastInteractor(), weatherType: type)
            vc.forecastPresenter = presenter
        } else {
            let presenter = WeatherPresenter(view: vc, interactor: CurrentWeatherInteractor(), weatherType: type)
            vc.forecastPresenter = presenter
        }
        return vc
    }
    
}
