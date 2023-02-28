//
//  WeatherItem+CoreDataProperties.swift
//  
//
//  Created by mac on 27/02/2023.
//
//

import Foundation
import CoreData


extension WeatherItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherItem> {
        return NSFetchRequest<WeatherItem>(entityName: "WeatherItem")
    }

    @NSManaged public var cityName: String?
    @NSManaged public var weatherF_Temp: String?
    @NSManaged public var weatherC_Temp: String?
    @NSManaged public var weatherLat: String?
    @NSManaged public var weatherLong: String?

}
