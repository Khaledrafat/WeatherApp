//
//  Extensions.swift
//  WeatherApp
//
//  Created by mac on 26/02/2023.
//

import UIKit

// MARK: - Default String
extension Optional where Wrapped == String {
    var emptyString: String {
        return self ?? ""
    }
}

// MARK: - Default Double
extension Optional where Wrapped == Double {
    var emptyDouble: Double {
        return self ?? 0
    }
}

// MARK: - Default Double
extension Optional where Wrapped == Int {
    var emptyInt: Int {
        return self ?? 0
    }
}
