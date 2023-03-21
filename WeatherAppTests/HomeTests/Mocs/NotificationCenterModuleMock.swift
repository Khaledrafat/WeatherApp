//
//  NotificationCenterModuleMock.swift
//  WeatherAppTests
//
//  Created by mac on 21/03/2023.
//

import Foundation
@testable import WeatherApp

class NotificationCenterWeatherModuleMock : WeatherModelPR {
    var weatherType: WeatherApp.WeatherType?
    
    var weatherF_Temp: String?
    
    var weatherC_Temp: String
    
    var weatherCity: String?
    
    var weatherLat: String?
    
    var weatherLong: String?
    
    init(_ temp : String) {
        self.weatherC_Temp = temp
    }
    
    init(_ temp : String ,_ type : WeatherType ,_ city : String) {
        self.weatherC_Temp = temp
        self.weatherType = type
        self.weatherCity = city
    }
    
}
