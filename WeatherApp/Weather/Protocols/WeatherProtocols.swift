//
//  ForecastProtocols.swift
//  WeatherApp
//
//  Created by mac on 26/02/2023.
//

import Foundation

// MARK: - Presenter
protocol WeatherPresenterPR{
    func changeDegreeType()
    func fetchItems()
    func selectCell(index : Int)
    func getCellsCount() -> Int
    func setupCell(cell : WeatherCellPR, index : Int)
    func getWeatherByLocation(_ location : String)
    func getLocationFromCity(_ city : String)
    func getLocationFromZip(_ zip : String)
    func openForcastForSelectedLocation(weatherType: WeatherType) -> WeatherVC
}

// MARK: - ForecastWeather
protocol WeatherVCPR{
    func startLoading()
    func endLoading()
    func requestFailedWith(message : String)
    func weatherFetchedSucessfully(weather : WeatherModelPR)
    func wrongLocationFormat()
    func degreeTypeChanged(weather : WeatherModelPR?)
    func reloadData()
}

// MARK: - Network
protocol WeatherInteractorPR{
    func searchWeatherByLocation(lat : String , long : String , completion : @escaping (Result<WeatherModelPR, Result_Errors>)->())
    func getLocationByCityName(_ name : String , completion: @escaping (Result<WeatherModelPR, Result_Errors>) -> ())
    func getLocationByZipCode(_ code : String , completion: @escaping (Result<WeatherModelPR, Result_Errors>) -> ())
}

// MARK: - Weather Model Protocol
protocol WeatherModelPR{
    var weatherType : WeatherType? { get }
    var weatherF_Temp : String? { get }
    var weatherC_Temp : String { get }
    var weatherCity : String? { get }
    var weatherLat : String? { get }
    var weatherLong : String? { get }
}

// MARK: - Weather Data Source
protocol WeatherDataSourcePR{
    func fetchItems() -> [WeatherModelPR]
    func create_Save_Item(weather : WeatherModelPR)
}

protocol WeatherCellPR{
    func setup(lat: String , long: String , name: String)
}
