//
//  WeatherVC+location.swift
//  WeatherApp
//
//  Created by mac on 28/02/2023.
//

import UIKit
import CoreLocation
import CoreLocationUI

extension WeatherVC: CLLocationManagerDelegate {
    func setupLocation() {
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue = locations.last?.coordinate else { return }
        print(locValue)
        if typeSegment.selectedSegmentIndex == 1 , shouldGetCurrentLocation {
            let location = "\(locValue.longitude) , \(locValue.latitude)"
            self.forecastPresenter?.getWeatherByLocation(location)
            self.shouldGetCurrentLocation = false
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways , .authorizedWhenInUse:
            manager.startUpdatingLocation()
        default:
            self.showFailureAlert("Please Turn On your Device Location")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.showFailureAlert(error.localizedDescription)
    }
    
    func requestLocationUpdates() {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedAlways , .authorizedWhenInUse:
            manager.startUpdatingLocation()
        default:
            self.showFailureAlert("Please Turn On your Device Location")
        }
    }
}
