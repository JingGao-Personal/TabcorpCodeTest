//
//  DetailViewModel.swift
//  TabcorpCodeTest
//
//  Created by Jing Gao on 15/9/18.
//  Copyright © 2018 Jing Gao. All rights reserved.
//

import RxSwift

class DetailViewModel {
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    private let specificWeatherSubject: BehaviorSubject<SpecificWeatherInfo?> = BehaviorSubject(value: nil)
    
    lazy var specificWeather: Observable<SpecificWeatherInfo> = specificWeatherSubject.flatMap { Observable.from(optional: $0)}
}
