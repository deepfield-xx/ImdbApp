//
//  MovieCastCircleView.swift
//  ImdbApp
//
//  Created by Tom on 03/02/2022.
//

import UIKit

protocol MovieCastCircleViewDelegate: AnyObject {
    func movieCastCircleViewDidSelect(_ actor: MovieActor)
}

final class MovieCastCircleView: UIView {
    private let actors: [MovieActor]
    private var collectionView: UICollectionView!
    
    weak var delegate: MovieCastCircleViewDelegate?
    
    init(actors: [MovieActor]) {
        self.actors = actors
        super.init(frame: .zero)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: MovieCastCircleLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MovieActorViewCell.self,
                                forCellWithReuseIdentifier: "MovieActorViewCell")
        addSubview(collectionView)
        
        let constraints = [collectionView.widthAnchor.constraint(equalTo: widthAnchor, constant: -40),
                           collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor),
                           collectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
                           collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)]
        NSLayoutConstraint.activate(constraints)
        collectionView.reloadData()
        DispatchQueue.main.async {
            self.centerCollectionView(at: IndexPath(item: Int(Double(self.actors.count)/2.0),
                                                    section: 0),
                                      animated: false)
        }
    }
        
    private func centerCollectionView(at indexPath: IndexPath, animated: Bool) {
        if let attr = self.collectionView.layoutAttributesForItem(at: indexPath) {
            let position = CGPoint(x: attr.center.x - collectionView.bounds.width/2,
                                   y: attr.center.y - collectionView.bounds.height/2)
            collectionView.setContentOffset(position, animated: animated)
        }
    }
}

extension MovieCastCircleView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieActorViewCell", for: indexPath) as? MovieActorViewCell else {
            fatalError("Fail to obtain cell for reuseId: MovieActorViewCell")
        }
        
        cell.label?.text = "\(indexPath.row)"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actors.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        centerCollectionView(at: indexPath, animated: true)
        delegate?.movieCastCircleViewDidSelect(actors[indexPath.row])
    }
}
