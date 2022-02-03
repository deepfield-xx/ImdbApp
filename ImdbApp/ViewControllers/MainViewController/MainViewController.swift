//
//  ViewController.swift
//  ImdbApp
//
//  Created by Tom on 03/02/2022.
//

import UIKit
import RxSwift

class MainViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        fetchMovieCast()
    }
    
    private func fetchMovieCast() {
        dependencies.api.getFullCast(of: "tt1375666")
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { cast in
                print(cast)
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }


}

