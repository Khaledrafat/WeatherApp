//
//  DataSourceModel.swift
//  WeatherApp
//
//  Created by mac on 28/02/2023.
//

import Foundation

struct DataSourceModel : WeatherModel_PR {
    var weatherType: WeatherType?
    
    var weatherF_Temp: String?
    
    var weatherC_Temp: String
    
    var weatherCity: String?
    
    var weatherLat: String?
    
    var weatherLong: String?
}
