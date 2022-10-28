//
//  DailyForecastData.swift
//  WeatherApp
//
//  Created by Samed Dağlı on 22.10.2022.
//

import Foundation

struct DailyForecastData: Codable{
    let city: City
    let list: [List]
    
}

struct City: Codable{
    let name: String
}

struct DailyWeather: Codable{
    let list: [List]
}

struct List: Codable{
    let main: MainProperties
    let weather: [WeatherProperties]
    let dt_txt: String
}

struct MainProperties: Codable{
    let temp: Double
}

struct WeatherProperties: Codable{
    let id: Int
    let description: String
}
