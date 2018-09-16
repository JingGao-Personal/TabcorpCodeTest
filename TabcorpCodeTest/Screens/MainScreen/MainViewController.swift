//
//  ViewController.swift
//  TabcorpCodeTest
//
//  Created by Jing Gao on 13/9/18.
//  Copyright © 2018 Jing Gao. All rights reserved.
//

import UIKit
import RxSwift
import MapKit

class MainViewController: UIViewController {

    private let disposeBag: DisposeBag = DisposeBag()
    private let viewModel: MainViewModel = MainViewModel()

    // MARK: - UI
    private lazy var mapView: MKMapView = {
        let mapView: MKMapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.delegate = self
       
        return mapView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mapView)
        
        setupUI()
        bindViewModel()
    }

    func setupUI() {
        NSLayoutConstraint.activate([
                mapView.topAnchor.constraint(equalTo: self.view.topAnchor),
                mapView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
                mapView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
                mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
    }
    
    func bindViewModel() {
        
        viewModel.annotations
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] annotations in
                self?.mapView.addAnnotations(annotations)
            })
            .disposed(by: disposeBag)
        
        viewModel.allPinsMapRect
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] rect in
                self?.mapView.setVisibleMapRect(rect, edgePadding: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50), animated: true)
            })
            .disposed(by: disposeBag)
    
    }


}

extension MainViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? PinAnnotation else { return nil }
        
        var view: MKMarkerAnnotationView
        
        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: PinAnnotation.viewIdentifier) as? MKMarkerAnnotationView {
            annotationView.annotation = annotation
            return annotationView
        }
        
        view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: PinAnnotation.viewIdentifier)
        view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        view.canShowCallout = true
        
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let annotation = view.annotation as? PinAnnotation {
            let detailsViewController = DetailViewController(id: annotation.id)
            self.navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }
}
