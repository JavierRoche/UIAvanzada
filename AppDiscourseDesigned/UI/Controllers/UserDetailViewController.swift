//
//  UserDetailViewController.swift
//  AppDiscourseDesigned
//
//  Created by APPLE on 28/05/2020.
//  Copyright © 2020 Javier Roche. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    let caDiscourseURLDomain: String = "https://mdiscourse.keepcoding.io"
    let caCreated: String = "created"
    let caAnswers: String = "answers"
    let caGiven: String = "given"
    let caReceived: String = "received"
    let caBadges: String = "Badges"
    let caEditor: String = "Editor"
    let caBasic: String = "Basic"
    private var user: User?
    
    lazy var blackView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = UIColor.black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var avatarImage: UIImageView = {
        let image: UIImageView = UIImageView()
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 92.5
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var usernameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.style28Bold
        label.textColor = UIColor.tangerine
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.style18regular
        label.textColor = UIColor.tangerine
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var messagesImage: UIImageView = {
        let image: UIImageView = UIImageView()
        image.image = UIImage.init(named: "icoMessage")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var whiteView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var topicImage: UIImageView = {
        let image: UIImageView = UIImageView()
        image.image = UIImage.init(named: "icoTopics")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var topicCreatedValue: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.style28Bold
        label.numberOfLines = 1
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var topicCreated: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.style13regular
        label.numberOfLines = 1
        label.text = caCreated
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var topicAnswersValue: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.style28Bold
        label.numberOfLines = 1
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var topicAnswers: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.style13regular
        label.numberOfLines = 1
        label.text = caAnswers
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var likeImage: UIImageView = {
        let image: UIImageView = UIImageView()
        image.image = UIImage.init(named: "icoLikes")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    lazy var givenLikesValue: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.style28Bold
        label.numberOfLines = 1
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var givenLikes: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.style13regular
        label.numberOfLines = 1
        label.text = caGiven
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var receivesLikesValue: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.style28Bold
        label.numberOfLines = 1
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var receivesLikes: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.style13regular
        label.numberOfLines = 1
        label.text = caReceived
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var badgesView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = UIColor.white
        view.layer.borderColor = UIColor.borderstyle.cgColor
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var badgesLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.style18bold
        label.numberOfLines = 1
        label.text = caBadges
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var editorImage: UIImageView = {
        let image: UIImageView = UIImageView()
        image.image = UIImage.init(named: "editorIcon")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var basicImage: UIImageView = {
        let image: UIImageView = UIImageView()
        image.image = UIImage.init(named: "basicIcon")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var editorLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.style11regular
        label.numberOfLines = 1
        label.text = caEditor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var basicLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.style11regular
        label.numberOfLines = 1
        label.text = caBasic
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var tableView: UITableView = {
        let table: UITableView = UITableView()
        table.rowHeight = 96
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    
    // MARK: init
    
    convenience init(user: User) {
        self.init(nibName: String(describing: UserDetailViewController.self), bundle: nil)
        self.user = user
    }
    
    override func loadView() {
        setViewsHierarchy()
        setConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Informamos el nombre y el nick
        usernameLabel.text = user?.username
        nameLabel.text = user?.name
        /// Completamos la url con el avatar y fijamos la imagen
        guard let urlImage = user?.avatarTemplate else { return }
        let url: String = "\(self.caDiscourseURLDomain)\(urlImage)"
        let avatarURL: String = url.replacingOccurrences(of: "{size}", with: "185")
        setAvatarImage(avatarURL: avatarURL)
        
        /// Podria haber seguido informando todos los datos con una nueva llamada al API pero esto iba de diseño
    }
        
    
    // MARK: Functions
       
    fileprivate func setViewsHierarchy() {
        view = UIView()
        
        view.backgroundColor = UIColor.tangerine
        view.addSubview(blackView)
        view.addSubview(avatarImage)
        view.addSubview(usernameLabel)
        view.addSubview(nameLabel)
        view.addSubview(messagesImage)
        view.addSubview(whiteView)
        view.addSubview(topicImage)
        view.addSubview(topicCreatedValue)
        view.addSubview(topicCreated)
        view.addSubview(topicAnswersValue)
        view.addSubview(topicAnswers)
        view.addSubview(likeImage)
        view.addSubview(givenLikesValue)
        view.addSubview(givenLikes)
        view.addSubview(receivesLikesValue)
        view.addSubview(receivesLikes)
        view.addSubview(badgesView)
        view.addSubview(badgesLabel)
        view.addSubview(editorImage)
        view.addSubview(basicImage)
        view.addSubview(editorLabel)
        view.addSubview(basicLabel)
        view.addSubview(tableView)
        view.bringSubviewToFront(messagesImage)
        view.bringSubviewToFront(usernameLabel)
        view.bringSubviewToFront(nameLabel)
    }
    
    fileprivate func setConstraints() {
        NSLayoutConstraint.activate([
            blackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 187.0),
            blackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            blackView.heightAnchor.constraint(equalToConstant: 245)
        ])
        
        NSLayoutConstraint.activate([
            avatarImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImage.centerYAnchor.constraint(equalTo: blackView.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 16.0),
            usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 34.0)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 5.0),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            messagesImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            messagesImage.centerYAnchor.constraint(equalTo: whiteView.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            whiteView.topAnchor.constraint(equalTo: blackView.bottomAnchor),
            whiteView.widthAnchor.constraint(equalTo: view.widthAnchor),
            whiteView.heightAnchor.constraint(equalToConstant: 136)
        ])
        
        NSLayoutConstraint.activate([
            topicImage.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: 71.0),
            topicImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 14.0)
        ])
        
        NSLayoutConstraint.activate([
            topicCreatedValue.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: 61.0),
            topicCreatedValue.leadingAnchor.constraint(equalTo: topicImage.trailingAnchor, constant: 15.5),
            topicCreatedValue.widthAnchor.constraint(equalToConstant: 49.0)
        ])
        
        NSLayoutConstraint.activate([
            topicCreated.topAnchor.constraint(equalTo: topicCreatedValue.bottomAnchor, constant: -0.5),
            topicCreated.leadingAnchor.constraint(equalTo: topicCreatedValue.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            topicAnswersValue.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: 61.0),
            topicAnswersValue.leadingAnchor.constraint(equalTo: topicCreatedValue.trailingAnchor, constant: 13.0),
            topicAnswersValue.widthAnchor.constraint(equalToConstant: 49.0)
        ])
        
        NSLayoutConstraint.activate([
            topicAnswers.topAnchor.constraint(equalTo: topicAnswersValue.bottomAnchor, constant: -0.5),
            topicAnswers.leadingAnchor.constraint(equalTo: topicAnswersValue.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            likeImage.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: 69.0),
            likeImage.leadingAnchor.constraint(equalTo: topicAnswersValue.trailingAnchor, constant: 39.5)
        ])
        
        NSLayoutConstraint.activate([
            givenLikesValue.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: 61.0),
            givenLikesValue.leadingAnchor.constraint(equalTo: likeImage.trailingAnchor, constant: 15.5),
            givenLikesValue.widthAnchor.constraint(equalToConstant: 49.0)
        ])
        
        NSLayoutConstraint.activate([
            givenLikes.topAnchor.constraint(equalTo: givenLikesValue.bottomAnchor, constant: -0.5),
            givenLikes.leadingAnchor.constraint(equalTo: givenLikesValue.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            receivesLikesValue.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: 61.0),
            receivesLikesValue.leadingAnchor.constraint(equalTo: givenLikesValue.trailingAnchor, constant: 11.0),
            receivesLikesValue.widthAnchor.constraint(equalToConstant: 49.0)
        ])
        
        NSLayoutConstraint.activate([
            receivesLikes.topAnchor.constraint(equalTo: receivesLikesValue.bottomAnchor, constant: -0.5),
            receivesLikes.leadingAnchor.constraint(equalTo: receivesLikesValue.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            badgesView.topAnchor.constraint(equalTo: whiteView.bottomAnchor),
            badgesView.widthAnchor.constraint(equalTo: view.widthAnchor),
            badgesView.heightAnchor.constraint(equalToConstant: 158)
        ])
        
        NSLayoutConstraint.activate([
            badgesLabel.topAnchor.constraint(equalTo: badgesView.topAnchor, constant: 16.0),
            badgesLabel.leadingAnchor.constraint(equalTo: badgesView.leadingAnchor, constant: 16.0),
            badgesLabel.heightAnchor.constraint(equalToConstant: 28.0)
        ])
        
        NSLayoutConstraint.activate([
            editorImage.topAnchor.constraint(equalTo: badgesLabel.bottomAnchor, constant: 5.0),
            editorImage.leadingAnchor.constraint(equalTo: badgesView.leadingAnchor, constant: 17.0)
        ])
        
        NSLayoutConstraint.activate([
            basicImage.topAnchor.constraint(equalTo: badgesLabel.bottomAnchor, constant: 5.0),
            basicImage.leadingAnchor.constraint(equalTo: editorImage.trailingAnchor, constant: 12.0)
        ])
        
        NSLayoutConstraint.activate([
            editorLabel.topAnchor.constraint(equalTo: editorImage.bottomAnchor, constant: 5.0),
            editorLabel.centerXAnchor.constraint(equalTo: editorImage.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            basicLabel.topAnchor.constraint(equalTo: editorImage.bottomAnchor, constant: 5.0),
            basicLabel.centerXAnchor.constraint(equalTo: basicImage.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: badgesView.bottomAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    fileprivate func setAvatarImage(avatarURL: String) {
        DispatchQueue.global(qos:.userInitiated).async { [weak self] in
            guard let self = self,
                  let avatarURL: URL = URL(string: avatarURL),
                  let data = try? Data(contentsOf: avatarURL) else { return }
            DispatchQueue.main.async {
                self.avatarImage.image = UIImage(data: data)
                self.avatarImage.setNeedsLayout()
            }
        }
    }
}
    
    
    

