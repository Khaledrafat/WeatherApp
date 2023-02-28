//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by mac on 28/02/2023.
//

import UIKit

class WeatherCell: UITableViewCell , WeatherCellPR{

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = 4
    }
    
    func setup(lat: String , long: String , name: String){
        self.cityName.text = name
        self.locationLbl.text = "\(long) , \(lat)"
    }
    
}
