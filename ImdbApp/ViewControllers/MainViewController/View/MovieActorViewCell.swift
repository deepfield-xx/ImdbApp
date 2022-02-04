//
//  MovieActorViewCell.swift
//  ImdbApp
//
//  Created by Tom on 03/02/2022.
//

import UIKit

final class MovieActorViewCell: UICollectionViewCell {
    private var imageView: UIImageView!
    var label: UILabel?
    
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
        imageView = UIImageView()
        imageView.frame = bounds.insetBy(dx: 10, dy: 10)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = imageView.frame.width / 2.0
        imageView.backgroundColor = .blue
        contentView.addSubview(imageView)
        
        label = UILabel()
        label?.frame = imageView.frame
        label?.textColor = .black
        contentView.addSubview(label!)
        
    }
}
