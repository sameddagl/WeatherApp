//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Samed Dağlı on 21.10.2022.
//

import Foundation

protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weatherModel: WeatherModel)
    func didFailWithError(_ weatherManager: WeatherManager, error: Error)
}

struct WeatherManager {
    let baseCurrentWeatherUrl = "https://api.openweathermap.org/data/2.5/weather?lang=en&units=metric&lang=en&appid=0d1b79d9db1a7772ae91a250f8567105"
    
    static var shared = WeatherManager()
    var delegate: WeatherManagerDelegate?
    func fetchWeather(with cityName: String){
        let url = "\(baseCurrentWeatherUrl)&q=\(cityName)"
        print(url)
        performRequest(url)
    }
    func fetchWeather(lat: Double, lon: Double){
        let url = "\(baseCurrentWeatherUrl)&lat=\(lat)&lon=\(lon)"
        performRequest(url)
    }
    private func performRequest(_ urlString: String){
        if let url = URL(string: urlString){
            let urlSession = URLSession(configuration: .default)
            let task = urlSession.dataTask(with: url) { data, response, error in
                if let error = error{
                    self.delegate?.didFailWithError(self, error: error)
                    return
                }
                if let safeData = data{
                    if let weather = self.decodeJson(safeData){
                        self.delegate?.didUpdateWeather(self, weatherModel: weather)
                    }
                }
            }
            task.resume()
        }
    }
    private func decodeJson(_ data: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            let id = decodedData.weather[0].id
            let cityName = decodedData.name
            let country = decodedData.sys.country
            let description = decodedData.weather[0].description
            let currentTemp = decodedData.main.temp
            let pressure = decodedData.main.pressure
            let humidity = decodedData.main.humidity
            let windSpeed = decodedData.wind.speed

            let weatherModel = WeatherModel(id: id, cityName: cityName,country: country ,description: description, currentTemp: currentTemp, pressure: pressure, humidity: humidity, windSpeed: windSpeed)
            return weatherModel
            
        }
        catch{
            self.delegate?.didFailWithError(self, error: error)
            return nil
        }
    }
}
