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
        dependencies.api.getFullCast(of: "tt1375666") // Inception
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] cast in
                self?.addMovieCastView(cast.actors)
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }

    private func addMovieCastView(_ actors: [MovieActor]) {
        let movieCastView = MovieCastCircleView(actors: actors)
        movieCastView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(movieCastView)
        
        let movieActorNameView = MovieActorNameView()
        movieActorNameView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(movieActorNameView)
        
        movieCastView.delegate = movieActorNameView
        
        let constraint = [movieCastView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 60),
                          movieCastView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                          movieCastView.widthAnchor.constraint(equalTo: view.widthAnchor),
                          movieCastView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
                          movieActorNameView.topAnchor.constraint(equalTo: movieCastView.bottomAnchor),
                          movieActorNameView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                          movieActorNameView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                          movieActorNameView.bottomAnchor.constraint(equalTo: view.bottomAnchor)]
        NSLayoutConstraint.activate(constraint)
    }
}

