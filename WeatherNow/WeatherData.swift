//
//  WeatherData.swift
//  WeatherNow
//
//

import Foundation

struct CurrentWeather: Decodable {
    let weather: [Weather]
    let main: weatherData
    var name = "name"
}

struct Weather: Decodable {
    let weatherId: Int
    let weatherName: String?
    let weatherDescription: String?
    let weatherIcon: String?
    
    enum CodingKeys: String, CodingKey {
        case weatherId = "id"
        case weatherName = "main"
        case weatherDescription = "description"
        case weatherIcon = "icon"
    }
}

struct weatherData: Decodable {
    let temp: Double?
    let humidity: Double?
    let tempMax: Double?
    let tempMin: Double?
    
    enum CodingKeys: String, CodingKey {
        case temp
        case humidity
        case tempMax = "temp_max"
        case tempMin = "temp_min"
   }
}
