//
//  WeatherVC+TableView.swift
//  WeatherApp
//
//  Created by mac on 27/02/2023.
//

import UIKit

extension WeatherVC : UITableViewDelegate , UITableViewDataSource {
    
    // MARK: - Setup Table
    func setupTableView() {
        historyTable.dataSource = self
        historyTable.delegate = self
        historyTable.register(UINib(nibName: "WeatherCell", bundle: nil), forCellReuseIdentifier: "WeatherCell")
    }
    
    // MARK: - Cells Count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        (self.forecastPresenter?.getCellsCount()).emptyInt
    }
    
    // MARK: - Cell For Row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherCell else { return UITableViewCell() }
        forecastPresenter?.setupCell(cell: cell, index: indexPath.row)
        cell.selectionStyle = .none
        return cell
    }
    
    // MARK: - Did Select Cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        forecastPresenter?.selectCell(index: indexPath.row)
    }
}
