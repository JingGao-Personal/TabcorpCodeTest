//
//  MainViewModel.swift
//  TabcorpCodeTest
//
//  Created by Jing Gao on 16/9/18.
//  Copyright © 2018 Jing Gao. All rights reserved.
//

import RxSwift
import MapKit

class MainViewModel {
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Observables
    private let content: BehaviorSubject<Content?> = BehaviorSubject(value: nil)
    
    lazy var annotations: Observable<[PinAnnotation]> = {
        return content
            .flatMap { Observable.from(optional: $0) }
            .map { $0.list }
            .map { $0.map { PinAnnotation(id: $0.id ,coordinate: $0.coordinate, title: $0.name, subtitle: "") }  }
    }()
    
    lazy var allPinsMapRect: Observable<MKMapRect> = {
        annotations
            .map { annotations -> MKMapRect in
                var zoomRect: MKMapRect = MKMapRectNull
                for annotation in annotations {
                    let aPoint: MKMapPoint = MKMapPointForCoordinate(annotation.coordinate)
                    let rect: MKMapRect = MKMapRectMake(aPoint.x, aPoint.y, 0.1, 0.1)
                    if MKMapRectIsNull(zoomRect) {
                        zoomRect = rect
                    } else {
                        zoomRect = MKMapRectUnion(zoomRect, rect)
                    }
                }
                
                return zoomRect
            }
    }()
    
    // MARK: - Initialization
    init() {
        
        APIService.requestWeather()
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
            .observeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onSuccess: { [weak self] content in
                self?.content.onNext(content)
            })
            .disposed(by: disposeBag)
    }
    
    
}
