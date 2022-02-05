//
//  MovieActorNameView.swift
//  ImdbApp
//
//  Created by Tom on 05/02/2022.
//

import UIKit

final class MovieActorNameView: UIView {
    private let actorNameLabel = UILabel()
    private let actorRoleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        backgroundColor = UIColor.appYellow
        
        actorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        actorNameLabel.font = UIFont.postGroteskBold(17)
        actorNameLabel.textAlignment = .center
        actorNameLabel.textColor = .black
        addSubview(actorNameLabel)
        
        actorRoleLabel.translatesAutoresizingMaskIntoConstraints = false
        actorRoleLabel.font = UIFont.postGroteskBook(14)
        actorRoleLabel.textAlignment = .center
        actorRoleLabel.textColor = .black
        addSubview(actorRoleLabel)
        
        let constraints = [actorNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 29),
                           actorNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                           actorNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10),
                           actorNameLabel.bottomAnchor.constraint(equalTo: actorRoleLabel.topAnchor, constant: 11),
                           actorRoleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                           actorRoleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10)]
        NSLayoutConstraint.activate(constraints)
    }
    
    func updateActorName(_ name: String) {
        actorNameLabel.text = name
    }
    
    func updateActorAs(_ role: String) {
        actorRoleLabel.text = role
    }
}
