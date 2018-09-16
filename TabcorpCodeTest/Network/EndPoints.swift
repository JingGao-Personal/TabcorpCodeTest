//
//  EndPoints.swift
//  TabcorpCodeTest
//
//  Created by Jing Gao on 16/9/18.
//  Copyright © 2018 Jing Gao. All rights reserved.
//

import Foundation

class EndPoints {
    
    static let session = URLSession.shared
    
    static let baseUrl = "https://samples.openweathermap.org/data/2.5/box/city?bbox=12,32,15,37,10&appid=b1b15e88fa797225412429c1c50c122a1"
    
    static func specificUrl(id: Int) -> String {
        return "https://samples.openweathermap.org/data/2.5/weather?id=\(id)&appid=b1b15e88fa797225412429c1c50c122a1"
    }
}
