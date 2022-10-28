//
//  ViewController.swift
//  WeatherApp
//
//  Created by Samed Dağlı on 21.10.2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherImageLabel: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var pressureTextLabel: UILabel!
    @IBOutlet weak var humidityTextLabel: UILabel!
    @IBOutlet weak var windTextLabel: UILabel!
    
    @IBOutlet var nextDayLabels: [UILabel]!
    @IBOutlet var nextDayImageViews: [UIImageView]!
    @IBOutlet var nextDayTempLabels: [UILabel]!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        WeatherManager.shared.delegate = self
        DailyForecastManager.shared.delegate = self
        print("View didload called")

        
        locationManager.showsBackgroundLocationIndicator = true
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        showIndicator()
    }
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "goToSearch", sender: self)
    }
    func createAlert(title: String, message: String) -> UIAlertController{
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .cancel)
        alertController.addAction(okAction)
        return alertController
    }

}

//MARK: - WeatherManagerDelegate
extension ViewController: WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weatherModel: WeatherModel) {
        DispatchQueue.main.async {
            self.cityNameLabel.text = "\(weatherModel.cityName), \(weatherModel.country)"
            self.weatherImageLabel.image = UIImage(systemName: weatherModel.weatherImageName)
            self.descriptionLabel.text = weatherModel.description.capitalized
            self.tempLabel.text = weatherModel.currentTempString
            self.pressureTextLabel.text = weatherModel.pressureString
            self.humidityTextLabel.text = weatherModel.humidityString
            self.windTextLabel.text = weatherModel.windSpeedString
        }
    }
    func didFailWithError(_ weatherManager: WeatherManager, error: Error) {
        DispatchQueue.main.async {
            self.removeIndicator()
            let alertController = self.createAlert(title: "An error occured", message: "You might have misspelled")
            self.present(alertController, animated: true)
        }
    }
}
//MARK: - DailyForecastManagerDelegate
extension ViewController: DailyForecastManagerDelegate{
    func didUpdateWeather(_ dailyForecastManager: DailyForecastManager, weather: DailyForecastModel) {
        DispatchQueue.main.async {
            self.removeIndicator()
            for i in 0..<self.nextDayLabels.count{
                self.nextDayLabels[i].text = weather.datesText[i]
                self.nextDayImageViews[i].image = UIImage(systemName: weather.imageName[i])
                self.nextDayTempLabels[i].text = weather.tempString[i]
            }
        }
    }
    func didFailWithError(_ dailyForecastManager: DailyForecastManager, error: Error) {
        self.removeIndicator()
        print("Error with daily forecast manager")
    }
}
//MARK: - CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate{
    @IBAction func locationButtonClicked(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            WeatherManager.shared.fetchWeather(lat: lat, lon: lon)
            DailyForecastManager.shared.fetchWeather(lat: lat, lon: lon)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        DispatchQueue.main.async {
            self.removeIndicator()
            let alertController = self.createAlert(title: "No location", message: "Couldn't able to get the location")
            self.present(alertController, animated: true)
        }
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch locationManager.authorizationStatus {
        case .notDetermined, .restricted, .denied:
            self.removeIndicator()
            let alertController = self.createAlert(title: "Location services are not enabled", message: "Please allow us to use the location services.")
            present(alertController, animated: true)
        case .authorizedAlways, .authorizedWhenInUse:
            print("Access")
        default:
            break
        }
        
    }
}

