//
//  CurrentWeatherInteractor.swift
//  WeatherApp
//
//  Created by mac on 27/02/2023.
//

import Foundation

class CurrentWeatherInteractor : WeatherInteractor_PR {
    
    // MARK: - Get Weather By Location
    func searchWeatherByLocation(lat: String, long: String, completion: @escaping (Result<WeatherModel_PR , Result_Errors>) -> ()) {
        let id = Constants.appID
        let st_url = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(long)&appid=\(id)"
        let network = Network()
        guard let url = URL(string: st_url) else {
            completion(.failure(.errorMessage(message: "Something Went Wrong")))
            return
        }
        network.request(url: url, params: nil, headers: nil, method: .post) { (response : Result<CurrentModel , Result_Errors>) in
            switch response {
            case .success(let model):
                if model.weatherLat != nil && model.weatherLong != nil {
                    completion(.success(model))
                } else {
                    completion(.failure(.errorMessage(message: "Something Went Wrong")))
                }
            case .failure(let err):
                completion(.failure(.errorMessage(message: err.localizedDescription)))
            }
        }
    }
    
    // MARK: - Get Weather By City Name
    func getLocationByCityName(_ name : String , completion: @escaping (Result<WeatherModel_PR , Result_Errors>) -> ()) {
        let id = Constants.appID
        let st_url = "https://api.openweathermap.org/data/2.5/weather?q=\(name)&appid=\(id)"
        let network = Network()
        guard let url = URL(string: st_url) else {
            completion(.failure(.errorMessage(message: "Something Went Wrong")))
            return
        }
        network.request(url: url, params: nil, headers: nil, method: .post) { (response : Result<CurrentModel , Result_Errors>) in
            switch response {
            case .success(let model):
                if model.weatherLat != nil && model.weatherLong != nil {
                    completion(.success(model))
                } else {
                    completion(.failure(.errorMessage(message: "Something Went Wrong")))
                }
            case .failure(let err):
                completion(.failure(.errorMessage(message: err.localizedDescription)))
            }
        }
    }
    
    // MARK: - Get Weather By Zip Code
    func getLocationByZipCode(_ code : String , completion: @escaping (Result<WeatherModel_PR , Result_Errors>) -> ()) {
        let id = Constants.appID
        let st_url = "https://api.openweathermap.org/data/2.5/weather?zip=\(code)&appid=\(id)"
        let network = Network()
        guard let url = URL(string: st_url) else {
            completion(.failure(.errorMessage(message: "Something Went Wrong")))
            return
        }
        network.request(url: url, params: nil, headers: nil, method: .post) { (response : Result<CurrentModel , Result_Errors>) in
            switch response {
            case .success(let model):
                if model.weatherLat != nil && model.weatherLong != nil {
                    completion(.success(model))
                } else {
                    completion(.failure(.errorMessage(message: "Something Went Wrong")))
                }
            case .failure(let err):
                completion(.failure(.errorMessage(message: err.localizedDescription)))
            }
        }
    }
    
}
