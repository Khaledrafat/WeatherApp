//
//  Constants.swift
//  WeatherApp
//
//  Created by mac on 26/02/2023.
//

import Foundation

enum degreeType {
    case C , F
    
    var degree : String {
        switch self {
        case .C:    return " °C"
        case .F:    return " °F"
        }
    }
    
    var degreeTitle : String {
        switch self {
        case .C:    return "Celsius"
        case .F:    return "Fahrenheit"
        }
    }
}

class Constants {
    static var appID : String = "a7c74f7e2b497c59f87d6f90ff867344"
    static var degreeType : degreeType = .C
    static var apiVerion : String = "data/2.5/"
    static var apiBaseURL : String = "https://api.openweathermap.org/"
}
