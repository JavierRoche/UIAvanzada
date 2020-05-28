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
    let view: UIView = UIView()
    let tangerineView: UIView = UIView()
    let messageTitle: UILabel = UILabel()
    let messageContent: UILabel = UILabel()
    let pushpinImage: UIImageView = UIImageView()
    weak var delegate: WellcomeCellDelegate?
    
    func configureCell() {
        /// Creamos la jerarquia de elementos de la celda
        addSubview(view)
        view.addSubview(tangerineView)
        view.addSubview(messageTitle)
        view.addSubview(messageContent)
        view.addSubview(pushpinImage)
        
        /// Propiedades de la celda
        self.backgroundColor = UIColor.black
        /// Propiedades de la pegatina
        tangerineView.layer.cornerRadius = 8.0
        tangerineView.backgroundColor = UIColor.tangerine
        /// Propiedades de los label
        messageTitle.font = UIFont.style22bold
        messageTitle.numberOfLines = 0
        messageTitle.text = caMessageTitle
        messageContent.font = UIFont.style17regular
        messageContent.numberOfLines = 2
        messageContent.text = caMessageContent
        /// Propiedades de la UIImageView
        pushpinImage.image = UIImage.init(named: "pushpin")
        pushpinImage.contentMode = .scaleAspectFit
        pushpinImage.isUserInteractionEnabled = true
        pushpinImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pushpinImageTapped)))
        
        /// Fijamos las constraints de los elementos
        setConstraints()
    }
    
    fileprivate func setConstraints() {
        view.translatesAutoresizingMaskIntoConstraints = false
        tangerineView.translatesAutoresizingMaskIntoConstraints = false
        messageTitle.translatesAutoresizingMaskIntoConstraints = false
        messageContent.translatesAutoresizingMaskIntoConstraints = false
        pushpinImage.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: View father constraints
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            view.widthAnchor.constraint(equalToConstant: contentView.bounds.width),
            view.heightAnchor.constraint(equalToConstant: contentView.bounds.height)
        ])
        
        // MARK: Tangerine View constraints
        NSLayoutConstraint.activate([
            tangerineView.topAnchor.constraint(equalTo: self.topAnchor, constant: 25.0),
            tangerineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
            tangerineView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16.0),
            tangerineView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -23.0)
        ])

        // MARK: Message Title constraints
        NSLayoutConstraint.activate([
            messageTitle.topAnchor.constraint(equalTo: tangerineView.topAnchor, constant: 9),
            messageTitle.leadingAnchor.constraint(equalTo: tangerineView.leadingAnchor, constant: 18),
            messageTitle.rightAnchor.constraint(equalTo: tangerineView.rightAnchor, constant: 46),
            messageTitle.heightAnchor.constraint(equalToConstant: 28)
        ])

        // MARK: Message Title constraints
        NSLayoutConstraint.activate([
            messageContent.topAnchor.constraint(equalTo: messageTitle.bottomAnchor, constant: 6),
            messageContent.leadingAnchor.constraint(equalTo: tangerineView.leadingAnchor, constant: 18),
            messageContent.rightAnchor.constraint(equalTo: tangerineView.rightAnchor, constant: 73)
        ])

        // MARK: Pushpin constraints
        NSLayoutConstraint.activate([
            pushpinImage.topAnchor.constraint(equalTo: tangerineView.topAnchor, constant: 11),
            pushpinImage.rightAnchor.constraint(equalTo: tangerineView.rightAnchor, constant: -15)
//            messageTitle.widthAnchor.constraint(equalToConstant: 28),
//            messageTitle.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    @objc private func pushpinImageTapped(_ sender: UITapGestureRecognizer) {
        print("pushpinImageTapped")
        delegate?.takeOffWellcomeCell()
    }
}
