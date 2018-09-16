//
//  SpecificWeatherModel.swift
//  TabcorpCodeTest
//
//  Created by Jing Gao on 14/9/18.
//  Copyright © 2018 Jing Gao. All rights reserved.
//

struct SpecificWeatherInfo: Codable {
    
    enum CodingKeys: String, CodingKey {
        case coordinate = "coord"
        case weather
        case base
        case main
        case visibility
        case wind
        case clouds
        case dayTime = "dt"
        case system = "sys"
        case id
        case name
        case code = "cod"
    }
    
    
    let coordinate: Coordinate
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dayTime: Int
    let system: System
    let id: Int
    let name: String
    let code: Int
}
