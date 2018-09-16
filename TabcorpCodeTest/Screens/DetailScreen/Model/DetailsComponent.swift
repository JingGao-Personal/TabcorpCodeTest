//
//  DetailsComponent.swift
//  TabcorpCodeTest
//
//  Created by Jing Gao on 16/9/18.
//  Copyright © 2018 Jing Gao. All rights reserved.
//

enum DetailsComponent {
    case weather
    case temperature
    case humidity
    case windSpeed
    case visibility
    
    var title: String {
        switch self {
        case .weather: return "Weather: "
        case .temperature: return "Temperature:"
        case .humidity: return "Humidity:"
        case .windSpeed: return "Wind speed:"
        case .visibility: return "Visibility:"
        }
    }
    
}
