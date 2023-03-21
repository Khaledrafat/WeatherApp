//
//  NotificationCenterExtension.swift
//  WeatherApp
//
//  Created by mac on 21/03/2023.
//

import Foundation

protocol notificationCenterPR {
    func addObserver(_ observer : Any, selector: Selector, name: NSNotification.Name?, object: Any?)
    func removeObserver(_ observer: Any)
}

extension NotificationCenter : notificationCenterPR {
    
}

class customNotificationCenter : notificationCenterPR {
    
    var notificationName : NSNotification.Name?
    var isRemoved : Bool = false
    
    func addObserver(_ observer: Any, selector: Selector, name: NSNotification.Name?, object: Any?) {
        self.notificationName = name
    }
    
    func removeObserver(_ observer: Any) {
        self.isRemoved = true
    }
}
