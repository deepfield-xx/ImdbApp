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
    private var gradientOverlay: GradientView!
    
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
        backgroundColor = UIColor.gradientYellow
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: MovieCastCircleLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MovieActorViewCell.self,
                                forCellWithReuseIdentifier: "MovieActorViewCell")
        addSubview(collectionView)
        
        gradientOverlay = GradientView()
        gradientOverlay.isUserInteractionEnabled = false
        gradientOverlay.translatesAutoresizingMaskIntoConstraints = false
        gradientOverlay.startColor = UIColor.gradientYellow.withAlphaComponent(0)
        gradientOverlay.endColor = UIColor.gradientYellow
        gradientOverlay.gradientCenter = CGPoint.zero
        gradientOverlay.gradientLocation = [0.5, 1]
        gradientOverlay.radius = 0
        addSubview(gradientOverlay)
        
        let constraints = [collectionView.widthAnchor.constraint(equalTo: widthAnchor, constant: -40),
                           collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor),
                           collectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
                           collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
                           gradientOverlay.topAnchor.constraint(equalTo: collectionView.topAnchor),
                           gradientOverlay.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
                           gradientOverlay.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
                           gradientOverlay.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor)]
        NSLayoutConstraint.activate(constraints)
        
        collectionView.reloadData()
        DispatchQueue.main.async {
            self.centerCollectionView(at: IndexPath(item: Int(Double(self.actors.count)/2.0),
                                                    section: 0),
                                      animated: false)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientOverlay.gradientCenter = CGPoint(x: collectionView.bounds.width/2,
                                                 y: collectionView.bounds.height/2)
        gradientOverlay.radius = collectionView.bounds.width/2
        gradientOverlay.setNeedsDisplay()
    }
        
    private func centerCollectionView(at indexPath: IndexPath, animated: Bool) {
        if let attr = self.collectionView.layoutAttributesForItem(at: indexPath) {
            let position = CGPoint(x: attr.center.x - collectionView.bounds.width/2,
                                   y: attr.center.y - collectionView.bounds.height/2)
            collectionView.setContentOffset(position, animated: animated)
        }
    }
    
    private func getOffsetIndex(_ index: Int) -> Int {
        return (index + Int(actors.count/2) + 1) % actors.count
    }
}

extension MovieCastCircleView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieActorViewCell", for: indexPath) as? MovieActorViewCell else {
            fatalError("Fail to obtain cell for reuseId: MovieActorViewCell")
        }
        
        let offsetRow = getOffsetIndex(indexPath.row)
        let actor = actors[offsetRow]
        cell.loadActorImage(actor.image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actors.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        centerCollectionView(at: indexPath, animated: true)
        
        let offsetRow = getOffsetIndex(indexPath.row)
        delegate?.movieCastCircleViewDidSelect(actors[offsetRow])
    }
}
