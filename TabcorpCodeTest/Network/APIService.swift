//
//  APIService.swift
//  TabcorpCodeTest
//
//  Created by Jing Gao on 16/9/18.
//  Copyright © 2018 Jing Gao. All rights reserved.
//

import RxSwift

class APIService {
    
    static func requestWeather() -> Single<Content> {
        return request(EndPoints.baseUrl)
            .flatMap { data -> Single<Content> in
                guard let content: Content = try? JSONDecoder().decode(Content.self, from: data) else {
                    return Single.error(NetworkError.parsing)
                }
                return Single.just(content)
        }
    }

    static func requestSpecificWeather(id: Int) -> Single<SpecificWeatherInfo> {
        return request(EndPoints.specificUrl(id: id))
            .flatMap { data -> Single<SpecificWeatherInfo> in
                guard let info: SpecificWeatherInfo = try? JSONDecoder().decode(SpecificWeatherInfo.self, from: data) else {
                    return Single.error(NetworkError.parsing)
                }
                return Single.just(info)
        }
    }
    
    private static func request(_ url: String) -> Single<Data> {
        
        return Single<Data>.create { single in
            
            guard let urlString = URL(string: url) else {
                single(.error(NetworkError.invalidUrl))
                return Disposables.create()
            }
            
            let task = EndPoints.session.dataTask(with: urlString) { data, _, error in
                if let error = error { return single(.error(NetworkError.request(error: error)))}
                guard let data: Data = data else { return single(.error(NetworkError.invalidData))}
                
                single(.success(data))
            }
            
            task.resume()
            
            return Disposables.create { task.cancel() }
        }
    }
}
