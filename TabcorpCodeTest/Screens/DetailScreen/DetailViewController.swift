//
//  DetailViewController.swift
//  TabcorpCodeTest
//
//  Created by Jing Gao on 15/9/18.
//  Copyright © 2018 Jing Gao. All rights reserved.
//

import UIKit
import RxSwift

class DetailViewController: UIViewController {
    
    private let disposeBag: DisposeBag = DisposeBag()
    private let viewModel: DetailViewModel
    
    // MARK: - UI
    lazy var stackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
                
        return stackView
    }()
    
    lazy var weatherView: DetailView = {
        let view: DetailView = DetailView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        viewModel.weather
            .bind(to: view.rx.detail)
            .disposed(by: disposeBag)
        
        return view
    }()
    
    lazy var temperatureView: DetailView = {
        let view: DetailView = DetailView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        viewModel.temperature
            .bind(to: view.rx.detail)
            .disposed(by: disposeBag)
        
        return view
    }()
    
    lazy var humidityView: DetailView = {
        let view: DetailView = DetailView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        viewModel.humidity
            .bind(to: view.rx.detail)
            .disposed(by: disposeBag)
        
        return view
    }()
    
    lazy var windSpeedView: DetailView = {
        let view: DetailView = DetailView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        viewModel.wind
            .bind(to: view.rx.detail)
            .disposed(by: disposeBag)
        
        return view
    }()
    
    lazy var visibilityView: DetailView = {
        let view: DetailView = DetailView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        viewModel.visibility
            .bind(to: view.rx.detail)
            .disposed(by: disposeBag)
        
        return view
    }()
    
    // MARK: - Initialization
    init(id: Int) {
        viewModel = DetailViewModel(id: id)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(weatherView)
        stackView.addArrangedSubview(temperatureView)
        stackView.addArrangedSubview(humidityView)
        stackView.addArrangedSubview(windSpeedView)
        stackView.addArrangedSubview(visibilityView)
        
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: view.topAnchor),
                stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
                stackView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
    }
    
    private func bindViewModel() {
        
        viewModel.title
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] title in
                self?.title = title
            })
            .disposed(by: disposeBag)
        
    }
}
