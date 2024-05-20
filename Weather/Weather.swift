//
//  Weather.swift
//  Weather
//
//  Created by user242921 on 5/17/24.
//

import Foundation
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let weather = try? JSONDecoder().decode(Weather.self, from: jsonData)

import Foundation

// MARK: - Weather
struct Weather: Codable {
    let location: Location?
    let current: Current?
    let forecast: Forecast?
}

// MARK: - Current
struct Current: Codable {
    let tempC: Double?
    let isDay: Int?
    let condition: Condition?
    let windKph: Double?
    let pressureMB: Double?
    let humidity: Double?
    let feelslikeC: Double?

    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case isDay = "is_day"
        case condition
        case windKph = "wind_kph"
        case pressureMB = "pressure_mb"
        case humidity
        case feelslikeC = "feelslike_c"
    }
}

// MARK: - Condition
struct Condition: Codable {
    let text: String?
    let icon: String?
    let code: Int?
}

// MARK: - Forecast
struct Forecast: Codable {
    let forecastday: [Forecastday]?
}

// MARK: - Forecastday
struct Forecastday: Codable,Identifiable {
    var id: UUID = UUID()
    let date: String?
    let dateEpoch: Int?
    let day: Day?
    let hour: [Hour]?
    
    enum CodingKeys: String, CodingKey {
        case date
        case dateEpoch = "date_epoch"
        case day, hour
    }
}


// MARK: - Day
struct Day: Codable {
    let maxtempC, mintempC: Double?
    let avgtempC: Double?
    let condition: Condition?

    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case mintempC = "mintemp_c"
        case avgtempC = "avgtemp_c"
        case condition
    }
}

// MARK: - Hour
struct Hour: Codable,Identifiable {
    var id: UUID = UUID()
    let timeEpoch: Int?
    let time: String?
    let tempC: Double?
    let isDay: Int?
    let condition: Condition?

    enum CodingKeys: String, CodingKey {
        case timeEpoch = "time_epoch"
        case time
        case tempC = "temp_c"
        case isDay = "is_day"
        case condition
    }
}

// MARK: - Location
struct Location: Codable {
    let name, region, country: String?
    let localtimeEpoch: Int?
    let localtime: String?

    enum CodingKeys: String, CodingKey {
        case name, region, country
        case localtimeEpoch = "localtime_epoch"
        case localtime
    }
}
struct Pair: Identifiable {
    var id = UUID()
    var first: String
    var second: String
}
