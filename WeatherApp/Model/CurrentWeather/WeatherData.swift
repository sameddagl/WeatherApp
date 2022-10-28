//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Samed Dağlı on 21.10.2022.
//

import Foundation

struct WeatherData: Codable{
    let name: String
    let main: Main
    let weather: [Weather]
    let wind: Wind
    let sys: Sys
}
struct Main: Codable{
    let temp: Double
    let pressure: Double
    let humidity: Double
    let temp_min: Double
    let temp_max: Double
}
struct Weather: Codable{
    let id: Int
    let description: String
}
struct Wind: Codable{
    let speed: Double
}
struct Sys: Codable{
    let country: String
}
