//
//  NetworkError.swift
//  TabcorpCodeTest
//
//  Created by Jing Gao on 16/9/18.
//  Copyright © 2018 Jing Gao. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case noNetwork
    case timeOut
    case invalidData
    case parsing
    case api
    case request(error: Error)
}

extension NetworkError {
    init(error: NSError) {
        switch error.code {
        case NSURLErrorTimedOut: self = .timeOut
        case NSURLErrorNotConnectedToInternet: self = .noNetwork
        default: self = .api
        }
    }
}
