//
//  ForecastInteractor.swift
//  WeatherApp
//
//  Created by mac on 26/02/2023.
//

import Foundation

class ForecastInteractor : WeatherInteractorPR{
    
    // MARK: - Get Weather By Location
    func searchWeatherByLocation(lat: String,
                                 long: String,
                                 completion: @escaping (Result<WeatherModelPR, Result_Errors>) -> ()) {
        let id = Constants.appID
        let st_url = "\(Constants.apiBaseURL)\(Constants.apiVerion)forecast?lat=\(lat)&lon=\(long)&appid=\(id)&cnt=1"
        let network = Network()
        guard let url = URL(string: st_url) else {
            completion(.failure(.errorMessage(message: "Something Went Wrong")))
            return
        }
        network.request(url: url,
                        params: nil,
                        headers: nil,
                        method: .post) { (response : Result<ForecastModel , Result_Errors>) in
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
    func getLocationByCityName(_ name: String ,
                               completion: @escaping (Result<WeatherModelPR, Result_Errors>) -> ()) {
        let id = Constants.appID
        let st_url = "\(Constants.apiBaseURL)\(Constants.apiVerion)forecast?q=\(name)&appid=\(id)&cnt=1"
        let network = Network()
        guard let url = URL(string: st_url) else {
            completion(.failure(.errorMessage(message: "Something Went Wrong")))
            return
        }
        network.request(url: url,
                        params: nil,
                        headers: nil,
                        method: .post) { (response : Result<ForecastModel , Result_Errors>) in
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
    func getLocationByZipCode(_ code: String ,
                              completion: @escaping (Result<WeatherModelPR, Result_Errors>) -> ()) {
        let id = Constants.appID
        let st_url = "\(Constants.apiBaseURL)\(Constants.apiVerion)forecast?zip=\(code)&appid=\(id)&cnt=1"
        let network = Network()
        guard let url = URL(string: st_url) else {
            completion(.failure(.errorMessage(message: "Something Went Wrong")))
            return
        }
        network.request(url: url,
                        params: nil,
                        headers: nil,
                        method: .post) { (response : Result<ForecastModel , Result_Errors>) in
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
