//
//  MovieActorViewCell.swift
//  ImdbApp
//
//  Created by Tom on 03/02/2022.
//

import UIKit
import Kingfisher

final class MovieActorViewCell: UICollectionViewCell {
    private var imageView = UIImageView()
    private let imageMask = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        contentView.layer.cornerRadius = frame.width / 2.0
        contentView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.9, alpha: 0.8).cgColor
        
        setUp()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        imageView.frame = bounds.insetBy(dx: 5, dy: 5)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = imageView.frame.width / 2.0
        contentView.addSubview(imageView)
        
        imageMask.backgroundColor = UIColor.white.cgColor
        imageMask.frame = imageView.bounds
        imageMask.cornerRadius = imageMask.frame.width / 2.0
        imageMask.transform = CATransform3DMakeScale(0, 0, 1)
        imageView.layer.mask = imageMask
        imageView.layer.masksToBounds = true
    }
    
    func loadActorImage(_ path: String) {
        let url = URL(string: path)
        imageView.kf.setImage(with: url)
    }
}
