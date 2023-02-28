//
//  WeatherDataSource.swift
//  WeatherApp
//
//  Created by mac on 27/02/2023.
//

import UIKit

class WeatherDataSource: WeatherDataSourcePR{
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var dataSourceItems : [WeatherItem] = []
    
    // MARK: - Fetch Items
    func fetchItems() -> [WeatherModelPR] {
        do {
            let items = try context.fetch(WeatherItem.fetchRequest())
            var dataSource = [DataSourceModel]()
            items.forEach({ item in
                let model = DataSourceModel(weatherType: nil, weatherF_Temp: item.weatherF_Temp, weatherC_Temp: item.weatherC_Temp.emptyString, weatherCity: item.cityName, weatherLat: item.weatherLat, weatherLong: item.weatherLong)
                dataSource.append(model)
            })
            self.dataSourceItems = items
            return dataSource
        }
        catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    // MARK: - Create & Save Item
    func create_Save_Item(weather : WeatherModelPR) {
        let item = WeatherItem(context: context)
        item.weatherLong = weather.weatherLong
        item.weatherLat = weather.weatherLat
        item.cityName = weather.weatherCity.emptyString
        item.weatherC_Temp = weather.weatherC_Temp
        item.weatherF_Temp = weather.weatherF_Temp
        if dataSourceItems.count >= 10 {
            let deletedItem = dataSourceItems[0]
            dataSourceItems.remove(at: 0)
            delete(item: deletedItem)
        }
        dataSourceItems.append(item)
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Delete Item In Core Data
    private func delete(item : WeatherItem) {
        let item = item
        context.delete(item)
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
