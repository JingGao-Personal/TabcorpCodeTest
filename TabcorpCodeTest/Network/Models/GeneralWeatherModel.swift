//
//  GeneralWeatherModel.swift
//  TabcorpCodeTest
//
//  Created by Jing Gao on 14/9/18.
//  Copyright © 2018 Jing Gao. All rights reserved.
//

struct GeneralWeatherInfo: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case coordinate = "coord"
    }
    
    let id: Int
    let name: String
    let coordinate: Coordinate
}


