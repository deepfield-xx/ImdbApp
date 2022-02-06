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
        contentView.layer.backgroundColor = UIColor.appYellow.cgColor
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        imageView.frame = bounds
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

        if ImageCache.default.isCached(forKey: path) {
            imageMask.transform = CATransform3DIdentity
            imageView.kf.setImage(with: url)
        } else {
            let processor = DownsamplingImageProcessor(size: imageView.bounds.size)
            imageView.kf.setImage(with: url, options: [.processor(processor), .scaleFactor(UIScreen.main.scale)]) { [weak self] result in
                let scaleAnim = CABasicAnimation(keyPath: "transform.scale")
                scaleAnim.fromValue = 0
                scaleAnim.toValue = 1
                scaleAnim.duration = 0.8
                scaleAnim.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
                scaleAnim.fillMode = .forwards
                scaleAnim.isRemovedOnCompletion = false
                
                self?.imageMask.add(scaleAnim, forKey: "scaleAnim")
            }
        }
    }
}
