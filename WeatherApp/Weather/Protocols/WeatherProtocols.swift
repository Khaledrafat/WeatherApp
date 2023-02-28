//
//  ForecastProtocols.swift
//  WeatherApp
//
//  Created by mac on 26/02/2023.
//

import Foundation

// MARK: - Presenter
protocol WeatherPresenter_PR {
    func changeDegreeType()
    func fetchItems()
    func selectCell(index : Int)
    func getCellsCount() -> Int
    func setupCell(cell : WeatherCell_PR , index : Int)
    func getWeatherByLocation(_ location : String)
    func getLocationFromCity(_ city : String)
    func getLocationFromZip(_ zip : String)
    func openForcastForSelectedLocation(weatherType: WeatherType) -> WeatherVC
}

// MARK: - ForecastWeather
protocol WeatherVC_PR {
    func startLoading()
    func endLoading()
    func requestFailedWith(message : String)
    func weatherFetchedSucessfully(weather : WeatherModel_PR)
    func wrongLocationFormat()
    func degreeTypeChanged(weather : WeatherModel_PR?)
    func reloadData()
}

// MARK: - Network
protocol WeatherInteractor_PR {
    func searchWeatherByLocation(lat : String , long : String , completion : @escaping (Result<WeatherModel_PR , Result_Errors>)->())
    func getLocationByCityName(_ name : String , completion: @escaping (Result<WeatherModel_PR , Result_Errors>) -> ())
    func getLocationByZipCode(_ code : String , completion: @escaping (Result<WeatherModel_PR , Result_Errors>) -> ())
}

// MARK: - Weather Model Protocol
protocol WeatherModel_PR {
    var weatherType : WeatherType? { get }
    var weatherF_Temp : String? { get }
    var weatherC_Temp : String { get }
    var weatherCity : String? { get }
    var weatherLat : String? { get }
    var weatherLong : String? { get }
}

// MARK: - Weather Data Source
protocol WeatherDataSource_PR {
    func fetchItems() -> [WeatherModel_PR]
    func create_Save_Item(weather : WeatherModel_PR)
}

protocol WeatherCell_PR {
    func setup(lat: String , long: String , name: String)
}
