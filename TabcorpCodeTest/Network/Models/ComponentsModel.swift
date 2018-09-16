//
//  ComponentsModel.swift
//  TabcorpCodeTest
//
//  Created by Jing Gao on 14/9/18.
//  Copyright © 2018 Jing Gao. All rights reserved.
//

import Foundation

struct Content: Codable {
    let cod: String
    let calctime: Double
    let cnt: Int
    let list: [GeneralWeatherInfo]
}

struct Coordinate: Codable {
    let longtitude: Double
    let latitude: Double
    
    enum CodingKeys: String, CodingKey {
        case longtitude = "lon"
        case latitude = "lat"
    }
}

struct Main: Codable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Double
    let sea_level: Double?
    let grnd_level: Double?
    let humidity: Int
}

struct Wind: Codable {
    let speed: Double
    let deg: Double
}

struct Rain: Codable {
    let threeH: Double
    
    enum CodingKeys: String, CodingKey {
        case threeH = "3h"
    }
}

struct Clouds: Codable {
    let all: Int
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct System: Codable {
    let type: Int
    let id: Int
    let message: Double
    let country: String
    let sunrise: Int
    let sunset: Int
}
