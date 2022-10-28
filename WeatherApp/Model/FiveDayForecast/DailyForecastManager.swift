//
//  DailyForecastManager.swift
//  WeatherApp
//
//  Created by Samed Dağlı on 22.10.2022.
//

import Foundation

protocol DailyForecastManagerDelegate{
    func didUpdateWeather(_ dailyForecastManager: DailyForecastManager, weather: DailyForecastModel)
    func didFailWithError(_ dailyForecastManager: DailyForecastManager, error: Error)
}

struct DailyForecastManager {
    let baseUrl = "https://api.openweathermap.org/data/2.5/forecast?lang=en&units=metric&appid=0d1b79d9db1a7772ae91a250f8567105"
    
    var delegate: DailyForecastManagerDelegate?
    static var shared = DailyForecastManager()
    func fetchWeather(with cityName: String){
        let urlString = "\(baseUrl)&q=\(cityName)"
        print(urlString)
        performRequest(urlString)
    }
    func fetchWeather(lat: Double, lon: Double){
        let urlString = "\(baseUrl)&lat=\(lat)&lon=\(lon)"
        performRequest(urlString)
    }
    
    func performRequest(_ urlString: String){
        if let url = URL(string: urlString){
            let urlSession = URLSession(configuration: .default)
            let task = urlSession.dataTask(with: URLRequest(url: url)) { data, response, error in
                if let error = error{
                    self.delegate?.didFailWithError(self, error: error)
                    return
                }
                if let safeData = data{
                    if let dailyWeather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather: dailyWeather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> DailyForecastModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(DailyForecastData.self, from: data)
            var ids = Array(repeating: 0, count: 5)
            var temps = Array(repeating: 0.0, count: 5)
            var dates = Array(repeating: "", count: 4)
            for i in 0...4{
                ids[i] = decodedData.list[i * 8].weather[0].id
                temps[i] = decodedData.list[i * 8].main.temp
            }
            for i in 0...3{
                dates[i] = getDayFrom(decodedData.list[i * 8 + 8].dt_txt)!

            }
            let dailyWeather = DailyForecastModel(id: ids, temp: temps, datesText: dates)
            return dailyWeather
        }
        catch{
            print(error)
            self.delegate?.didFailWithError(self, error: error)
            return nil
        }
    }
    
    private func getDayFrom(_ string: String) -> String?{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = formatter.date(from: string) else{return nil}
        
        formatter.dateFormat = "E"
        return formatter.string(from: date).uppercased()
    }
}

