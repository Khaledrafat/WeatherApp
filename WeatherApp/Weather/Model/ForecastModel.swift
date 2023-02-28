//
//  ForecastModel.swift
//  WeatherApp
//
//  Created by mac on 26/02/2023.
//

import Foundation

struct ForecastModel: Codable {
    let cnt: Int?
    let list: [ForecastList]?
    let city: ForecastCity?
}

// MARK: - City
struct ForecastCity: Codable {
    let id: Int?
    let name: String?
    let coord: ForecastCoord?
    let country: String?
    let population, timezone, sunrise, sunset: Int?
}

// MARK: - Coord
struct ForecastCoord: Codable {
    let lat, lon: Double?
}

// MARK: - List
struct ForecastList: Codable {
    let dt: Int?
    let main: ForecastMain?
    let weather: [ForecastWeather]?
    let clouds: ForecastClouds?
    let wind: ForecastWind?
    let visibility: Int?
    let pop: Double?
    let rain: Rain?
    let sys: ForecastSys?
    let dtTxt: String?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, rain, sys
        case dtTxt = "dt_txt"
    }
}

// MARK: - Clouds
struct ForecastClouds: Codable {
    let all: Int?
}

// MARK: - Main
struct ForecastMain: Codable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, seaLevel, grndLevel, humidity: Int?
    let tempKf: Double?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - Rain
struct Rain: Codable {
    let the3H: Double?

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - Sys
struct ForecastSys: Codable {
    let pod: String?
}

// MARK: - Weather
struct ForecastWeather: Codable {
    let id: Int?
    let main, description, icon: String?
}

// MARK: - Wind
struct ForecastWind: Codable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
}

// MARK: - Model Protocol
extension ForecastModel : WeatherModel_PR {
    var weatherType: WeatherType? {
        return .forecast
    }
    
    var weatherF_Temp: String? {
        if let weatherList = list , weatherList.count > 0 {
            let temp = (weatherList[0].main?.tempKf).emptyDouble
            return "\(temp)"
        }
        return ""
    }
    
    var weatherC_Temp: String {
        if let weatherList = list , weatherList.count > 0 {
            let temp = (weatherList[0].main?.temp).emptyDouble
            return "\(temp)"
        }
        return ""
    }
    
    var weatherCity: String? {
        if let name = city?.name {
            return name
        }
        return nil
    }
    
    var weatherLat: String? {
        if let lat = city?.coord?.lat {
            return "\(lat)"
        }
        return nil
    }
    
    var weatherLong: String? {
        if let long = city?.coord?.lon {
            return "\(long)"
        }
        return nil
    }
}
