//
//  TopicCell.swift
//  AppDiscourseDesigned
//
//  Created by APPLE on 24/05/2020.
//  Copyright © 2020 Javier Roche. All rights reserved.
//

import UIKit

class TopicCell: UITableViewCell {
    let caDateInputFormat = "YYYY-MM-DD'T'HH:mm:ss.SSSZ"    // "2020-01-19T19:28:16.151Z"
    let caDateOutputFormat = "MMM d"                        // May 25
    let avatarImage: UIImageView = UIImageView()
    let topicTitle: UILabel = UILabel()
    let groupedStack: UIStackView = UIStackView()
    let postcountStack: UIStackView = UIStackView()
    let postcountImage: UIImageView = UIImageView()
    let postcountLabel: UILabel = UILabel()
    let postersStack: UIStackView = UIStackView()
    let postersImage: UIImageView = UIImageView()
    let postersLabel: UILabel = UILabel()
    let dateStack: UIStackView = UIStackView()
    let dateImage: UIImageView = UIImageView()
    let dateLabel: UILabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(topic: Topic) {
        /// Aplicamos la jerarquia de vistas
        setViewsHierarchy()
        
        /// Aplicamos la propiedades a las vistas
        setViewProperties()
            
        /// Obtenemos la imagen del avatar
        guard let urlImage = topic.avatarURL else { return }
        setAvatarImage(avatarURL: urlImage)
            
        /// Informamos el titulo del topic
        topicTitle.text = topic.title
            
        /// Informamos la fecha del stack
        guard let date = topic.lastPostedAt else { return }
        dateLabel.text = formattedDate(topicDate: date)
        
        /// Informamos el postcount del stack
        guard let postcount = topic.postCount else { return }
        postcountLabel.text = String(postcount)
        
        /// Informamos el contador de posters del stack
        guard let posters = topic.posters?.count else { return }
        postersLabel.text = String(posters)
        
        /// Fijamos las constraints de los elementos
        setConstraints()
    }
        
        
    // MARK: Functions
        
    fileprivate func setViewsHierarchy() {
        /// Creamos la jerarquia de elementos de la celda
        self.addSubview(avatarImage)
        self.addSubview(topicTitle)
        self.addSubview(groupedStack)
        /// Añadimos a cada stack hijo sus elementos
        postcountStack.addArrangedSubview(postcountImage)
        postcountStack.addArrangedSubview(postcountLabel)
        postersStack.addArrangedSubview(postersImage)
        postersStack.addArrangedSubview(postersLabel)
        dateStack.addArrangedSubview(dateImage)
        dateStack.addArrangedSubview(dateLabel)
        /// Y al padre los stacks hijos
        groupedStack.addArrangedSubview(postcountStack)
        groupedStack.addArrangedSubview(postersStack)
        groupedStack.addArrangedSubview(dateStack)
    }
        
    fileprivate func setViewProperties() {
        /// Propiedades de la vista
        self.backgroundColor = UIColor.white246
        /// Propiedades de la UIImageView
        avatarImage.layer.masksToBounds = true
        avatarImage.layer.cornerRadius = 32.0
        /// Propiedades del label para el titulo del topic
        topicTitle.font = UIFont.style17semibold
        topicTitle.contentMode = .bottomLeft
        topicTitle.numberOfLines = 2
        /// Propiedades del stack padre
        groupedStack.setCustomSpacing(6, after: postcountStack)
        groupedStack.setCustomSpacing(7, after: postersStack)
        /// Propiedades del stack hijo postcount
        postcountStack.setCustomSpacing(4, after: postcountImage)
        postcountImage.image = UIImage.init(named: "icoSmallAnswers")
        postcountImage.contentMode = .scaleAspectFit
        postcountLabel.font = UIFont.countsStyle
        /// Propiedades del stack hijo posters
        postersStack.setCustomSpacing(4, after: postersImage)
        postersImage.image = UIImage.init(named: "icoViewsSmall")
        postersImage.contentMode = .scaleAspectFit
        postersLabel.font = UIFont.countsStyle
        /// Propiedades del stack hijo date
        dateStack.setCustomSpacing(4, after: dateImage)
        dateImage.image = UIImage.init(named: "icoSmallCalendar")
        dateImage.contentMode = .scaleAspectFit
        dateLabel.font = UIFont.dateStyle
    }
    
    fileprivate func setAvatarImage(avatarURL: String) {
        DispatchQueue.global(qos:.userInitiated).async { [weak self] in
            guard let avatarURL: URL = URL(string: avatarURL),
                    let data = try? Data(contentsOf: avatarURL) else { return }
            DispatchQueue.main.async {
                self?.avatarImage.image = UIImage(data: data)
                self?.avatarImage.setNeedsLayout()
            }
        }
    }
        
    fileprivate func formattedDate(topicDate: String) -> String? {
        /// Configuramos un DateFormatter con el formato esperado, lenguaje y zona horaria
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = caDateInputFormat
        dateFormatter.locale = Locale(identifier: "es_ES")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        /// Intentamos aplantillar la fecha recibida al formado dado, y despues ya la sacamos al formato de salida que queramos
        guard let date = dateFormatter.date(from: topicDate) else { return nil}
        /// Le fijamos el formato de salida y lo pasamos a String con el DateFormatter
        dateFormatter.dateFormat = caDateOutputFormat
        return dateFormatter.string(from: date).capitalized
    }
        
    fileprivate func setConstraints() {
        /// Linea obligatoria cuando creamos vistas autolayout-ables por codigo
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        topicTitle.translatesAutoresizingMaskIntoConstraints = false
        groupedStack.translatesAutoresizingMaskIntoConstraints = false
            
        // MARK: Avatar constraints
        NSLayoutConstraint.activate([
            /// Ajusta en horizontal a 16 del avatar y vertical centrado al padre
            avatarImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
            avatarImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            /// Ajusta el ancho y el alto
            avatarImage.widthAnchor.constraint(equalToConstant: 64.0),
            avatarImage.heightAnchor.constraint(equalToConstant: 64.0),
        ])
            
        // MARK: Topic Title constraints
        NSLayoutConstraint.activate([
            /// Ajusta en horizontal a 91 por la izquierda, 14 por arriba y 59 por la derecha del padre.
            topicTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 91.0),
            topicTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 14.0),
            topicTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -59.0)
        ])
            
        // MARK: Stack constraints
        NSLayoutConstraint.activate([
            /// Ajusta por abajo y por la izquierda del padre
            groupedStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 91.0),
            groupedStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -14.0),
        ])
    }
}
