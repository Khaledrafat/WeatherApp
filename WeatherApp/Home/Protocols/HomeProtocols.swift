//
//  File.swift
//  WeatherApp
//
//  Created by mac on 26/02/2023.
//

import UIKit

protocol HomePresenter_PR {
    func openWeatherVC(type: WeatherType) -> WeatherVC
}
