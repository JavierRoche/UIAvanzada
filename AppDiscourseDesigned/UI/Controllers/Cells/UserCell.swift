//
//  UserCell.swift
//  AppDiscourseDesigned
//
//  Created by APPLE on 27/05/2020.
//  Copyright © 2020 Javier Roche. All rights reserved.
//

import UIKit

class UserCell: UICollectionViewCell {
    let caDiscourseURLDomain: String = "https://mdiscourse.keepcoding.io"
    
    lazy var avatarImage: UIImageView = {
        let image: UIImageView = UIImageView()
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 40.0
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.style15regular
        label.textAlignment = .center
        label.contentMode = .top
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    //MARK: Init
    
    public func configureCell(user: User) {
        /// Aplicamos la jerarquia de vistas y propiedades
        setViewsHierarchy()
        
        /// Obtenemos la imagen del avatar
        setAvatarImage(avatarURL: user.avatarTemplate)
            
        /// Informamos el nombre del user
        nameLabel.text = user.name
        
        /// Fijamos las constraints de los elementos
        setConstraints()
    }
    
    // MARK: Functions
        
    fileprivate func setViewsHierarchy() {
        /// Creamos la jerarquia de elementos de la celda
        self.addSubview(avatarImage)
        self.addSubview(nameLabel)
    }
    
    fileprivate func setAvatarImage(avatarURL: String) {
        /// Completamos el dominio con la template del avatar
        let url: String = "\(caDiscourseURLDomain)\(avatarURL)"
        DispatchQueue.global(qos:.userInitiated).async { [weak self] in
            guard let avatarURL: URL = URL(string: url.replacingOccurrences(of: "{size}", with: "40")),
                    let data = try? Data(contentsOf: avatarURL) else { return }
            DispatchQueue.main.async {
                self?.avatarImage.image = UIImage(data: data)
                self?.avatarImage.setNeedsLayout()
            }
        }
    }
    
    fileprivate func setConstraints() {
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.0),
            avatarImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 7.0),
            avatarImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -7.0),
            avatarImage.heightAnchor.constraint(equalToConstant: 80.0)
        ])

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 9.0),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
