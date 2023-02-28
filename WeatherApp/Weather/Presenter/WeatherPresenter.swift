//
//  ForecastPresenter.swift
//  WeatherApp
//
//  Created by mac on 26/02/2023.
//

import Foundation
import UIKit

enum WeatherType { case forecast , current }

final class WeatherPresenter: WeatherPresenter_PR {
    
    private var view: WeatherVC_PR!
    private var interactor: WeatherInteractor_PR!
    private var weatherType: WeatherType!
    private var lastWeather: WeatherModel_PR?
    private var dataSource: WeatherDataSource_PR!
    private var weatherItems: [WeatherModel_PR] = []
    
    // MARK: - INIT
    init(view: WeatherVC_PR , interactor: WeatherInteractor_PR , weatherType: WeatherType , dataSource : WeatherDataSource_PR = WeatherDataSource()) {
        self.view = view
        self.interactor = interactor
        self.weatherType = weatherType
        self.dataSource = dataSource
    }
    
    // MARK: - Get Weather By Location
    func getWeatherByLocation(_ location: String) {
        guard location.contains(",") else { self.view.wrongLocationFormat() ; return }
        if let range = location.range(of: ",") {
            let lat = location[range.upperBound...].trimmingCharacters(in: .whitespaces)
            let long = String(location[location.startIndex..<range.lowerBound]).trimmingCharacters(in: .whitespaces)
            guard let _ = Double(lat) , let _ = Double(long) else { self.view.wrongLocationFormat() ; return }
            searchBy(lat: lat, long: long)
        }
    }
    
    // MARK: - Search By Location
    private func searchBy(lat: String , long: String) {
        self.view.startLoading()
        self.interactor.searchWeatherByLocation(lat: lat, long: long) {[weak self] response in
            guard let self = self else { return }
            self.view.endLoading()
            switch response {
            case .success(let res):
                self.view.weatherFetchedSucessfully(weather: res)
                self.lastWeather = res
                self.createItem(weather: res)
            case .failure(let err):
                self.view.requestFailedWith(message: err.message)
            }
        }
    }
    
    // MARK: - Get Location From Zip
    func getLocationFromZip(_ zip: String) {
        guard zip.trimmingCharacters(in: .whitespaces).count > 3 else {
            self.view.wrongLocationFormat()
            return
        }
        self.view.startLoading()
        interactor.getLocationByZipCode(zip.trimmingCharacters(in: .whitespaces)) { [weak self] response in
            guard let self = self else { return }
            self.view.endLoading()
            switch response {
            case .success(let res):
                self.view.weatherFetchedSucessfully(weather: res)
                self.lastWeather = res
                self.createItem(weather: res)
            case .failure(let err):
                self.view.requestFailedWith(message: err.message)
            }
        }
    }
    
    // MARK: - Get Location From City Name
    func getLocationFromCity(_ city: String) {
        guard city.trimmingCharacters(in: .whitespaces).count > 2 else {
            self.view.wrongLocationFormat()
            return
        }
        self.view.startLoading()
        interactor.getLocationByCityName(city.trimmingCharacters(in: .whitespaces)) { [weak self] response in
            guard let self = self else { return }
            self.view.endLoading()
            switch response {
            case .success(let res):
                self.view.weatherFetchedSucessfully(weather: res)
                self.lastWeather = res
                self.createItem(weather: res)
            case .failure(let err):
                self.view.requestFailedWith(message: err.message)
            }
        }
    }
    
    // MARK: - Open Forecast with Selected Location
    func openForcastForSelectedLocation(weatherType: WeatherType) -> WeatherVC {
        let vc = WeatherVC()
        var selectedIndex = 0
        var text = ""
        var type : locationType = .location
        if let lastWeather = lastWeather , let lat = lastWeather.weatherLat , let long = lastWeather.weatherLong {
            selectedIndex = 0
            text = "\(long) , \(lat)"
        } else if let lastWeather = lastWeather , let city = lastWeather.weatherCity {
            selectedIndex = 2
            text = city
            type = .city
        }
        vc.configureWithSelectedLocation(text, type, selectedIndex , weatherType)
        let presenter = WeatherPresenter(view: vc, interactor: ForecastInteractor(), weatherType: weatherType)
        vc.forecastPresenter = presenter
        return vc
    }
    
    // MARK: - Change Degree Type
    func changeDegreeType() {
        self.view.degreeTypeChanged(weather: self.lastWeather)
    }
    
    // MARK: - Create Item
    func createItem(weather : WeatherModel_PR) {
        dataSource.create_Save_Item(weather: weather)
        if weatherItems.count >= 10 {
            weatherItems.remove(at: 0)
        }
        weatherItems.append(weather)
        self.view.reloadData()
    }
    
    // MARK: - Fetch Items
    func fetchItems() {
        let data = dataSource.fetchItems()
        self.weatherItems = data
        self.view.reloadData()
    }
    
    // MARK: - Setup Cell
    func setupCell(cell : WeatherCell_PR , index : Int) {
        let data = weatherItems
        guard data.count > index else { return }
        let newIndex = data.count - index - 1
        cell.setup(lat: data[newIndex].weatherLat.emptyString
                    , long: data[newIndex].weatherLong.emptyString
                    , name: data[newIndex].weatherCity.emptyString)
    }
    
    // MARK: - Get Cells Count
    func getCellsCount() -> Int {
        if self.weatherType == .forecast , weatherItems.count > 5 {
            return 5
        } else if self.weatherType == .current , weatherItems.count > 10 {
            return 10
        }
        return weatherItems.count
    }
    
    // MARK: - Select Cell
    func selectCell(index : Int) {
        guard weatherItems.count > index else { return }
        let newIndex = weatherItems.count - index - 1
        let item = weatherItems[newIndex]
        guard self.weatherType == .current , newIndex >= 5 else {
            if let lat = item.weatherLat , let long = item.weatherLong {
                self.getWeatherByLocation("\(long) , \(lat)")
            } else if let city = item.weatherCity {
                self.getLocationFromCity(city)
            }
            return
        }
        self.view.weatherFetchedSucessfully(weather: item)
        self.lastWeather = item
        self.createItem(weather: item)
    }
    
}
