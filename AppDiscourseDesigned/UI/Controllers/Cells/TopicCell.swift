//
//  TopicCell.swift
//  AppDiscourseDesigned
//
//  Created by APPLE on 24/05/2020.
//  Copyright © 2020 Javier Roche. All rights reserved.
//

import UIKit

class TopicCell: UITableViewCell {
    let caDateInputFormat = "YYYY-MM-dd'T'HH:mm:ss.SSSZ"    // "2020-01-19T19:28:16.151Z"
    let caDateOutputFormat = "MMM d"                        // May 25
    
    lazy var avatarImage: UIImageView = {
        let image: UIImageView = UIImageView()
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 32.0
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.style17semibold
        label.numberOfLines = 2
        label.contentMode = .bottomLeft
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var groupedStack: UIStackView = {
        let stack: UIStackView = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var postcountStack: UIStackView = {
        let stack: UIStackView = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var postcountImage: UIImageView = {
        let image: UIImageView = UIImageView()
        image.image = UIImage.init(named: "icoSmallAnswers")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var postcountLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.countsStyle
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var postersStack: UIStackView = {
        let stack: UIStackView = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var postersImage: UIImageView = {
        let image: UIImageView = UIImageView()
        image.image = UIImage.init(named: "icoViewsSmall")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var postersLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.countsStyle
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dateStack: UIStackView = {
        let stack: UIStackView = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var dateImage: UIImageView = {
        let image: UIImageView = UIImageView()
        image.image = UIImage.init(named: "icoSmallCalendar")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var dateLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.dateStyle
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // MARK: Init
    
    public func configureCell(topic: Topic) {
        /// Aplicamos la jerarquia de vistas
        setViewsHierarchy()
        
        /// Aplicamos la propiedades a las vistas
        setViewProperties()
            
        /// Obtenemos la imagen del avatar
        guard let urlImage = topic.avatarURL else { return }
        setAvatarImage(avatarURL: urlImage)
            
        /// Informamos el titulo del topic
        titleLabel.text = topic.title
            
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
        self.addSubview(titleLabel)
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
        /// Propiedades de la UIImageView que hay que definir una vez el objeto creado
        avatarImage.alpha = 0
        /// El interespaciado de los stack hay que definirlo una vez el objeto creado
        groupedStack.setCustomSpacing(6, after: postcountStack)
        groupedStack.setCustomSpacing(7, after: postersStack)
        postcountStack.setCustomSpacing(4, after: postcountImage)
        postersStack.setCustomSpacing(4, after: postersImage)
        dateStack.setCustomSpacing(4, after: dateImage)
    }
    
    fileprivate func setAvatarImage(avatarURL: String) {
        DispatchQueue.global(qos:.userInitiated).async { [weak self] in
            guard let self = self,
                  let avatarURL: URL = URL(string: avatarURL),
                  let data = try? Data(contentsOf: avatarURL) else { return }
            DispatchQueue.main.async {
                self.avatarImage.image = UIImage(data: data)
                UIView.animate(withDuration: 0.6) {
                    self.avatarImage.alpha = 1
                }
                self.avatarImage.setNeedsLayout()
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
        guard let date = dateFormatter.date(from: topicDate) else { return nil }
        /// Le fijamos el formato de salida y lo pasamos a String con el DateFormatter
        dateFormatter.dateFormat = caDateOutputFormat
        return dateFormatter.string(from: date).capitalized
    }
        
    fileprivate func setConstraints() {
        NSLayoutConstraint.activate([
            /// Ajusta en horizontal a 16 del avatar y vertical centrado al padre
            avatarImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
            avatarImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            /// Ajusta el ancho y el alto
            avatarImage.widthAnchor.constraint(equalToConstant: 64.0),
            avatarImage.heightAnchor.constraint(equalToConstant: 64.0),
        ])
            
        NSLayoutConstraint.activate([
            /// Ajusta en horizontal a 91 por la izquierda, 14 por arriba y 59 por la derecha del padre.
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 14.0),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 91.0),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -59.0)
        ])
            
        NSLayoutConstraint.activate([
            /// Ajusta por abajo y por la izquierda del padre
            groupedStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 91.0),
            groupedStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -14.0),
        ])
    }
}
