//
//  DetailViewModel.swift
//  TabcorpCodeTest
//
//  Created by Jing Gao on 16/9/18.
//  Copyright © 2018 Jing Gao. All rights reserved.
//

import RxSwift

typealias DetailModel = (title: String, value: String)

class DetailViewModel {
    
    private let id: Int
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Observables

    private let detailContentSubject: BehaviorSubject<SpecificWeatherInfo?> = BehaviorSubject(value: nil)
    private lazy var detailContent: Observable<SpecificWeatherInfo> = {
        return detailContentSubject.flatMap { Observable.from(optional: $0) }
    }()
    
    lazy var title: Observable<String> = {
        return detailContent.map { $0.name }
    }()
    
    lazy var weather: Observable<DetailModel> = {
        return detailContent
            .map { $0.weather.first }
            .flatMap { Observable.from(optional: $0) }
            .map { DetailModel(title: DetailsComponent.weather.title, value: $0.main ) }
    }()
    
    lazy var wind: Observable<DetailModel> = {
       return detailContent
            .map { DetailModel(title: DetailsComponent.windSpeed.title, value: "\($0.wind.speed)")}
    }()
    
    lazy var temperature: Observable<DetailModel> = {
        return detailContent
            .map { DetailModel(title: DetailsComponent.temperature.title, value: "\($0.main.temp)")}
    }()
    
    lazy var visibility: Observable<DetailModel> = {
        return detailContent
            .map { DetailModel(title: DetailsComponent.visibility.title, value: "\($0.visibility)")}
    }()
    
    lazy var humidity: Observable<DetailModel> = {
        return detailContent
            .map { DetailModel(title: DetailsComponent.humidity.title, value: "\($0.main.humidity)")}
    }()
    
    init(id: Int) {
        self.id = id
        
        APIService.requestSpecificWeather(id: id)
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
            .observeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onSuccess: { [weak self] weatherInfo in
                self?.detailContentSubject.onNext(weatherInfo)
            })
            .disposed(by: disposeBag)
        
    }
}
