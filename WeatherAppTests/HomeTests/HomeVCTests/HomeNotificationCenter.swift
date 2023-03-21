//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by mac on 21/03/2023.
//

import XCTest
@testable import WeatherApp

final class HomeVCTest: XCTestCase {
    
    func test_notification_center_is_subscribing_successfully() {
        let notification = customNotificationCenter()
        let sut = HomeVC(notification: notification)
        sut.loadViewIfNeeded()
        XCTAssertEqual(notification.notificationName, NSNotification.Name("Weather"))
    }

    func test_notification_center_deinit() {
        let notification = customNotificationCenter()
        let sut = HomeVC(notification: notification)
        sut.loadViewIfNeeded()
        addTeardownBlock {
            XCTAssertEqual(notification.isRemoved, true)
        }
    }
    
    func test_home_tempLbl_is_working() {
        let sut = HomeVC()
        sut.loadView()
        let mock = NotificationCenterWeatherModuleMock("19")
        let notification = NSNotification(name: Notification.Name("Weather"), object: nil, userInfo: ["weather":mock])
        sut.weatherReceived(notification)
        XCTAssertEqual("19 °C", sut.weatherLbl.text)
    }

    func test_home_tempLbl_isnot_working() {
        let sut = HomeVC()
        sut.loadView()
        let notification = NSNotification(name: Notification.Name("Weather"), object: nil, userInfo: nil)
        sut.weatherReceived(notification)
        XCTAssertEqual("_  _ ", sut.weatherLbl.text)
    }

    func test_home_locationLbl_is_working_for_current() {
        let sut = HomeVC()
        sut.loadView()
        let mock = NotificationCenterWeatherModuleMock("22", .current, "Tanta")
        let notification = NSNotification(name: Notification.Name("Weather"), object: nil, userInfo: ["weather":mock])
        sut.weatherReceived(notification)
        XCTAssertEqual("Current Degree For: \n Tanta", sut.locationLbl.text)
    }

    func test_home_locationLbl_is_working_for_forcast() {
        let sut = HomeVC()
        sut.loadView()
        let mock = NotificationCenterWeatherModuleMock("22", .forecast, "Tanta")
        let notification = NSNotification(name: Notification.Name("Weather"), object: nil, userInfo: ["weather":mock])
        sut.weatherReceived(notification)
        XCTAssertEqual("Forecast Degree For: \n Tanta", sut.locationLbl.text)
    }

    func test_home_locationLbl_not_working() {
        let sut = HomeVC()
        sut.loadView()
        let notification = NSNotification(name: Notification.Name("Weather"), object: nil, userInfo: nil)
        sut.weatherReceived(notification)
        XCTAssertTrue(sut.locationLbl.isHidden)
    }

}
