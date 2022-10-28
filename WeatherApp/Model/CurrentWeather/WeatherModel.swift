//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Samed Dağlı on 21.10.2022.
//

import Foundation

struct WeatherModel {
    let id: Int
    let cityName: String
    let country: String
    let description: String
    let currentTemp: Double
    var currentTempString: String{
        return String(format: "%.1f °C", currentTemp)
    }
    let pressure: Double
    var pressureString: String{
        return String(format: "%.f hpaf", pressure)
    }
    let humidity: Double
    var humidityString: String{
        return "%\(Int(humidity))"
    }
    let windSpeed: Double
    var windSpeedString: String{
        return String(format: "%.1f km/h", windSpeed)
    }
    var weatherImageName: String{
        switch id{
            case 800:
                return "sun.max"
            case 801:
                return "cloud.sun.fill"
            case 802, 803, 804:
                return "cloud.fill"
            case 300, 301, 302, 310, 311, 312, 313, 314, 321, 520, 521, 522, 531:
                return "cloud.rain.fill"
            case 500, 501, 502, 503, 504, 511:
                return "cloud.sun.rain.fill"
            case 200, 201, 202, 210, 211, 212, 221, 230, 231, 232:
                return "cloud.bolt.fill"
            case 600, 601, 602, 611, 612, 613, 615, 616, 620, 621, 622:
                return "snowflake"
            case 701, 711, 721, 731, 741, 751, 761, 762, 771, 781:
                return "cloud.fog.fill"
            default:
                return "cloud"
        }
    }

    
}
