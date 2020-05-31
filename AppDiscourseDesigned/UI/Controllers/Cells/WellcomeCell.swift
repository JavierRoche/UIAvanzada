//
//  WellcomeCell.swift
//  AppDiscourseDesigned
//
//  Created by APPLE on 26/05/2020.
//  Copyright © 2020 Javier Roche. All rights reserved.
//

import UIKit

protocol WellcomeCellDelegate: class {
    func takeOffWellcomeCell()
}

class WellcomeCell: UITableViewCell {
    let caMessageTitle: String = "Wellcome e eh.ho"
    let caMessageContent: String = "Discourse Setup The first\nparagraph of this pinned topic"
    weak var delegate: WellcomeCellDelegate?
    
    lazy var tangerineView: UIView = {
        let view: UIView = UIView()
        view.layer.cornerRadius = 8.0
        view.backgroundColor = UIColor.tangerine
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.style22bold
        label.numberOfLines = 0
        label.text = caMessageTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var messageContent: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.style17regular
        label.numberOfLines = 2
        label.text = caMessageContent
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var pushpinImage: UIImageView = {
        let image: UIImageView = UIImageView()
        image.image = UIImage.init(named: "pushpin")
        image.contentMode = .scaleAspectFit
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pushpinImageTapped)))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    // MARK: Init
    
    public func configureCell() {
        /// Creamos la jerarquia de elementos de la celda
        self.backgroundColor = UIColor.black
        self.addSubview(tangerineView)
        self.addSubview(titleLabel)
        self.addSubview(messageContent)
        self.addSubview(pushpinImage)
        
        /// Fijamos las constraints de los elementos
        setConstraints()
    }
    
    fileprivate func setConstraints() {
        NSLayoutConstraint.activate([
            tangerineView.topAnchor.constraint(equalTo: self.topAnchor, constant: 25.0),
            tangerineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
            tangerineView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16.0),
            tangerineView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -23.0)
        ])

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: tangerineView.topAnchor, constant: 9),
            titleLabel.leadingAnchor.constraint(equalTo: tangerineView.leadingAnchor, constant: 18),
            titleLabel.rightAnchor.constraint(equalTo: tangerineView.rightAnchor, constant: 46),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])

        NSLayoutConstraint.activate([
            messageContent.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            messageContent.leadingAnchor.constraint(equalTo: tangerineView.leadingAnchor, constant: 18),
            messageContent.rightAnchor.constraint(equalTo: tangerineView.rightAnchor, constant: 73)
        ])

        NSLayoutConstraint.activate([
            pushpinImage.topAnchor.constraint(equalTo: tangerineView.topAnchor, constant: 11),
            pushpinImage.rightAnchor.constraint(equalTo: tangerineView.rightAnchor, constant: -15)
            /// Sino defines ancho y alto y le dices que coja la imagen original la redimensiona al original
//            messageTitle.widthAnchor.constraint(equalToConstant: 28),
//            messageTitle.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    @objc private func pushpinImageTapped(_ sender: UITapGestureRecognizer) {
        delegate?.takeOffWellcomeCell()
    }
}
