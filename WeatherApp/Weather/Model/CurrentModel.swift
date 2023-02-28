//
//  CurrentModel.swift
//  WeatherApp
//
//  Created by mac on 27/02/2023.
//

import Foundation

struct CurrentModel: Codable {
    let coord: CurrentCoord?
    let weather: [CurrentWeather]?
    let base: String?
    let main: CurrentMain?
    let visibility: Int?
    let wind: CurrentWind?
    let clouds: CurrentClouds?
    let dt: Int?
    let sys: CurrentSys?
    let timezone, id: Int?
    let name: String?
}

// MARK: - Clouds
struct CurrentClouds: Codable {
    let all: Int?
}

// MARK: - Coord
struct CurrentCoord: Codable {
    let lon, lat: Double?
}

// MARK: - Main
struct CurrentMain: Codable {
    let temp: Double?
    let pressure, humidity: Int?
    let tempMin, tempMax: Double?

    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

// MARK: - Sys
struct CurrentSys: Codable {
    let type, id: Int?
    let message: Double?
    let country: String?
    let sunrise, sunset: Int?
}

// MARK: - Weather
struct CurrentWeather: Codable {
    let id: Int?
    let main, description, icon: String?
}

// MARK: - Wind
struct CurrentWind: Codable {
    let speed: Double?
    let deg: Int?
}

// MARK: - Model Protocol
extension CurrentModel : WeatherModel_PR {
    var weatherType: WeatherType? {
        return .current
    }
    
    var weatherF_Temp: String? {
        if let weather = main {
            let temp = weather.temp.emptyDouble - Double(273)
            let st_temp = String(format: "%.2f", temp)
            return "\(st_temp)"
        }
        return ""
    }
    
    var weatherC_Temp: String {
        if let weather = main {
            let temp = weather.temp.emptyDouble
            return "\(temp)"
        }
        return ""
    }
    
    var weatherCity: String? {
        return self.name
    }
    
    var weatherLat: String? {
        if let lat = coord?.lat {
            return "\(lat)"
        }
        return nil
    }
    
    var weatherLong: String? {
        if let long = coord?.lon {
            return "\(long)"
        }
        return nil
    }
}
