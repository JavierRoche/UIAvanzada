//
//  TopicsViewController.swift
//  AppDiscourseDesigned
//
//  Created by APPLE on 22/05/2020.
//  Copyright © 2020 Javier Roche. All rights reserved.
//

import UIKit

class TopicsViewController: UIViewController {
    let caDiscourseURLDomain: String = "https://mdiscourse.keepcoding.io"
    var topics: [Topic] = []
    
    /// Definimos y configuramos la tabla
    lazy var tableView: UITableView = {
        let table: UITableView = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(TopicCell.self, forCellReuseIdentifier: "TopicCell")
        table.register(WellcomeCell.self, forCellReuseIdentifier: "WellcomeCell")
        table.estimatedRowHeight = 100
        table.rowHeight = UITableView.automaticDimension
        return table
    }()
    
    lazy var newButton: UIImageView = {
        let button: UIImageView = UIImageView(frame: .zero)
        button.image = UIImage.init(named: "icoNew")
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func loadView() {
        view = UIView()

        view.addSubview(tableView)
        // MARK: Table constraints
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
        
        view.addSubview(newButton)
        // MARK: View father constraints
        NSLayoutConstraint.activate([
            newButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15.0),
            newButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12.0)
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Topics"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.white246
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
                                                                        NSAttributedString.Key.font: UIFont.style34Bold]
        
        /// Recuperamos los datos de la tabla
        getData()
    }
    
    
    // MARK: Functions
    
    fileprivate func getData() {
        /// Con el objeto DataProvider accedemos a las funciones del API
        let dataProvider: DataProvider = DataProvider()
        dataProvider.latestTopicsAPIDiscourse { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.topics = response.topicList.topics
                
                let lastestPosters: [User] = response.users
                /// Por cada topic recuperamos el avatar del ultimo poster y lo incorporamos al modelo
                for index in 0..<self.topics.count {
                    /// Obtenemos el indice del array de users que tiene el ultimo posteador del topic
                    let auxIndex = lastestPosters.firstIndex(where: { (user) -> Bool in
                        user.username == self.topics[index].lastPosterUsername
                    })
                    guard let templateIndex = auxIndex else { return }
                    
                    /// Completamos la url con el avatar y actualizamos la info del array de topics
                    let url: String = "\(self.caDiscourseURLDomain)\(lastestPosters[templateIndex].avatarTemplate)"
                    let avatarURL: String = url.replacingOccurrences(of: "{size}", with: "40")
                    self.topics[index].avatarURL = avatarURL
                }
                self.tableView.reloadData()
                
            case .failure(let error):
                if let errorType = error as? ErrorTypes {
                    switch errorType {
                    case .malformedURL, .malformedData, .statusCode:
                        self.showAlert(title: "Error", message: errorType.description)
                    }
                    
                } else {
                    self.showAlert(title: "Server Error", message: error.localizedDescription)
                }
            }
        }
    }
}


// MARK: Delegate

extension TopicsViewController: UITableViewDelegate {
    /// Funcion delegada para altura de celda
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 151
        }
        return 96
    }
}


// MARK: Data Source

extension TopicsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WellcomeCell.self), for: indexPath) as? WellcomeCell {
                cell.configureCell()
                return cell
            }
            fatalError("")

        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TopicCell.self), for: indexPath) as? TopicCell {
                cell.configureCell(topic: topics[indexPath.row])
                return cell
            }
            fatalError("")
        }
    }
}
