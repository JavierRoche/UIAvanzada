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
    let caRefreshMessage: String = "Pull to refresh"
    let caTopics: String = "Topics"
    var wellcomed: Bool = false
    var topics: [Topic] = []
    
    lazy var tableView: UITableView = {
        let table: UITableView = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.refreshControl = refreshControl
        table.register(TopicCell.self, forCellReuseIdentifier: String(describing: TopicCell.self))
        table.register(WellcomeCell.self, forCellReuseIdentifier: String(describing: WellcomeCell.self))
        return table
    }()
    
    lazy var newButton: UIImageView = {
        let button: UIImageView = UIImageView(frame: .zero)
        button.image = UIImage.init(named: "icoNew")
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(newTopic)))
        return button
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refresh: UIRefreshControl = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: caRefreshMessage)
        refresh.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return refresh
    }()
    
    lazy var searchController: UISearchController = {
        let search: UISearchController = UISearchController()
        search.searchResultsUpdater = self
        search.searchBar.delegate = self
        search.searchBar.tintColor = UIColor.tangerine
        search.obscuresBackgroundDuringPresentation = false
        search.automaticallyShowsCancelButton = true
        return search
    }()
    
    
    // MARK: Init
    
    override func loadView() {
        /// Esto no lo entiendo muy bien. ¿Por que la view, que en teoria ya es la de self, se le asigna algo vacio? -.-
        view = UIView()

        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        view.addSubview(newButton)
        view.bringSubviewToFront(newButton)
        NSLayoutConstraint.activate([
            newButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15.0),
            newButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12.0)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Asignacion del UISearchController y atributos del navigationController
        self.navigationItem.searchController = searchController
        self.title = caTopics
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

                /// He dudado (por el RefreshControl) de dejar el DispatchQueue, pues me dijiste que en el viewDidLoad siempre estamos en mainqueue
//              DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.tableView.reloadData()
//              }
                
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
    
    @objc func refreshData() {
        getData()
    }
    
    @objc private func newTopic(_ sender: UITapGestureRecognizer) {
        let newTopicViewController: NewTopicViewController = NewTopicViewController.init()
        let navigationController: UINavigationController = UINavigationController.init(rootViewController: newTopicViewController)
        navigationController.modalPresentationStyle = UIDevice.current.userInterfaceIdiom == .pad ? .formSheet : .automatic
        self.present(navigationController, animated: true, completion: nil)
    }
}


// MARK: UISearchControll / UISearchBar Delegate

extension TopicsViewController: UISearchResultsUpdating, UISearchBarDelegate  {
    /// Funcion delegada de UISearchBar para controlar el click en cancel
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        getData()
        tableView.reloadData()
    }
    
    /// Funcion delegada de UISearchController que se ejecuta con cada caracter introducido en la UISearchBar
    func updateSearchResults(for searchController: UISearchController) {
        let filteredTopics = topics.filter { (topic: Topic) -> Bool in
            guard let topicTitle = topic.title, let text = searchController.searchBar.text?.lowercased() else { return false }
            if text == "" { return true }
            return topicTitle.lowercased().contains(text)
        }
        topics = filteredTopics
        tableView.reloadData()
    }
}


// MARK: UITableView Delegate

extension TopicsViewController: UITableViewDelegate, WellcomeCellDelegate {
    /// Funcion delegada que recibe la notificacion de click en la chincheta de la celda de bienvenida
    func takeOffWellcomeCell() {
        wellcomed = true
        topics.removeFirst()
        tableView.reloadData()
    }
    
    /// Funcion delegada para altura de celda de la tabla
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch wellcomed {
        case true:
            /// Una vez quitada la celda de bienvenida la altura de la celda es la normal
            return 96
            
        case false:
            /// Los diferentes tipos de altura hasta que se quita el clip de la chincheta
            if indexPath.row == 0 {
                return 151
            }
            return 96
        }
    }
    
    /// Funcion delegada para la seleccion de una celda de la tabla
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /// Deseleccionamos la celda
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


// MARK: UITableView Data Source

extension TopicsViewController: UITableViewDataSource {
    /// Funcion delegada del numero de celda de la tabla
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    /// Funcion delegada de llenado de la tabla
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch wellcomed {
        case true:
            /// Una vez quitada la celda de bienvenida ya todas son normales
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TopicCell.self), for: indexPath) as? TopicCell {
                cell.configureCell(topic: topics[indexPath.row])
                return cell
            }
            fatalError("Couldn't create cells")
            
        case false:
            /// Los diferentes tipos de celda hasta que se quita el clip de la chincheta
            if indexPath.row == 0 {
                if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WellcomeCell.self), for: indexPath) as? WellcomeCell {
                    cell.delegate = self
                    cell.configureCell()
                    return cell
                }
                fatalError("Couldn't create cells")

            } else {
                if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TopicCell.self), for: indexPath) as? TopicCell {
                    cell.configureCell(topic: topics[indexPath.row])
                    return cell
                }
                fatalError("Couldn't create cells")
            }
        }
    }
}
