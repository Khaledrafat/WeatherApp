//
//  ForecastVC.swift
//  WeatherApp
//
//  Created by mac on 26/02/2023.
//

import UIKit
import CoreLocation

enum locationType {
    case location , currentLocation , city , zip
    
    var hint: String {
        switch self {
        case .city:
            return "Enter City name"
        case .zip:
            return "Zip code"
        case .location:
            return "Enter The Latitude & Longitude seperated by ',' To Get the location"
        case .currentLocation:
            return "This Will Get The Weather of Your Current Location"
        }
    }
}

class WeatherVC: ParentVC {
    
    //Outlets
    @IBOutlet weak var degreeLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var historyTable: UITableView!
    @IBOutlet weak var switchDegreeBtn: UIButton!
    @IBOutlet weak var getWeatherBtn: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var hintLbl: UILabel!
    @IBOutlet weak var typeSegment: UISegmentedControl!
    @IBOutlet weak var getForcastBtn: UIButton!
    @IBOutlet weak var bgImage: UIImageView!
    
    //Variables
    var forecastPresenter: WeatherPresenter_PR?
    var location: CLLocationCoordinate2D?
    let manager = CLLocationManager()
    var screenType: WeatherType = .forecast
    var shouldGetCurrentLocation = false
    private var type: locationType = .location {
        didSet {
            self.hintLbl.text = self.type.hint
        }
    }
    
    //Passed Data
    private var shouldShowPassed: Bool = false
    private var passedType: locationType = .location
    private var passedText = ""
    private var passedScreenType: WeatherType = .current
    private var passedIndex = 0

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        forecastPresenter?.fetchItems()
        setupLocation()
    }
    
    // MARK: - Configure Pre-Selected Location
    func configureWithSelectedLocation(_ text: String , _ type: locationType , _ selectedSegmentIndex: Int , _ weatherType: WeatherType) {
        self.shouldShowPassed = true
        self.passedType = type
        self.passedText = text
        self.passedIndex = selectedSegmentIndex
        self.passedScreenType = weatherType
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        self.navigationController?.isNavigationBarHidden = true
        getWeatherBtn.layer.cornerRadius = 8
        getForcastBtn.layer.cornerRadius = 8
        hintLbl.text = self.type.hint
        if self.screenType == .current {
            self.bgImage.image = UIImage(named: "background")
            typeSegment.selectedSegmentTintColor = .white
            typeSegment.backgroundColor = .gray
            hintLbl.textColor = .white
            switchDegreeBtn.isHidden = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if shouldShowPassed {
            setupPassedData()
        }
    }
    
    // MARK: - Set Passed Data
    private func setupPassedData() {
        if shouldShowPassed {
            shouldShowPassed = false
            self.type = passedType
            self.textField.text = passedText
            self.typeSegment.selectedSegmentIndex = passedIndex
            self.screenType = passedScreenType
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
                guard let self = self else { return }
                self.getWeatherData()
            }
        }
    }
    
    // MARK: - Get Weather Data
    private func getWeatherData() {
        switch type {
        case .zip:
            self.forecastPresenter?.getLocationFromZip(textField.text.emptyString)
        case .city:
            self.forecastPresenter?.getLocationFromCity(textField.text.emptyString)
        case .currentLocation:
            shouldGetCurrentLocation = true
            requestLocationUpdates()
        case .location:
            self.forecastPresenter?.getWeatherByLocation(self.textField.text.emptyString)
        }
        self.view.endEditing(true)
    }
    
    // MARK: - Dismiss Button
    @IBAction func dismissButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - TextField Primary Action
    @IBAction func textFieldPrimaryAction(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    // MARK: - Switch Degree Button
    @IBAction func switchDegreeButton(_ sender: Any) {
        Constants.degreeType = Constants.degreeType == .C ? .F : .C
        self.forecastPresenter?.changeDegreeType()
        self.showNormalAlert("Switched To \(Constants.degreeType.degreeTitle)")
    }
    
    // MARK: - Get Weather Button
    @IBAction func getWeatherButton(_ sender: Any) {
        self.getWeatherData()
    }
    
    // MARK: - Segment Control
    @IBAction func segmentController(_ sender: UISegmentedControl) {
        UIView.animate(withDuration: 0.4) { [weak self] in
            guard let self = self else { return }
            self.textField.alpha = self.typeSegment.selectedSegmentIndex == 1 ? 0.4 : 1
            self.textField.isUserInteractionEnabled = self.typeSegment.selectedSegmentIndex != 1
        }
        self.view.endEditing(true)
        switch typeSegment.selectedSegmentIndex {
        case 0: self.type = .location
        case 1: self.type = .currentLocation
        case 2: self.type = .city
        case 3: self.type = .zip
        default: break
        }
    }
    
    // MARK: - Get Forcast Button
    @IBAction func getForcastButton(_ sender: Any) {
        guard let vc = self.forecastPresenter?.openForcastForSelectedLocation(weatherType: .forecast) else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
