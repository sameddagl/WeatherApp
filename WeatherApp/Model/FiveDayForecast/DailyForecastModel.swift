//
//  DailyForecastModel.swift
//  WeatherApp
//
//  Created by Samed Dağlı on 22.10.2022.
//

import Foundation

struct DailyForecastModel{
    let id: [Int]
    let temp: [Double]
    var tempString: [String]{
        var tempStringArray = [String]()
        for i in 0..<temp.count{
            tempStringArray.append(String(format: "%.1f °C", temp[i]))
        }
        return tempStringArray
    }
    let datesText: [String]
    var imageName: [String]{
        var nameArray = [String]()
        for i in id{
            switch i{
                case 800:
                    nameArray.append("sun.max.fill")
                case 801:
                    nameArray.append("cloud.sun.fill")
                case 802, 803, 804:
                    nameArray.append("cloud.fill")
                case 300, 301, 302, 310, 311, 312, 313, 314, 321, 520, 521, 522, 531:
                    nameArray.append("cloud.rain.fill")
                case 500, 501, 502, 503, 504, 511:
                    nameArray.append("cloud.sun.rain.fill")
                case 200, 201, 202, 210, 211, 212, 221, 230, 231, 232:
                    nameArray.append("cloud.bolt.fill")
                case 600, 601, 602, 611, 612, 613, 615, 616, 620, 621, 622:
                    nameArray.append("snowflake")
                case 701, 711, 721, 731, 741, 751, 761, 762, 771, 781:
                    nameArray.append("cloud.fog.fill")
                default:
                    nameArray.append("cloud")
            }
        }
        return nameArray
    }
}
