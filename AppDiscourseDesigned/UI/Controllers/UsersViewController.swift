//
//  UsersViewController.swift
//  AppDiscourseDesigned
//
//  Created by APPLE on 22/05/2020.
//  Copyright © 2020 Javier Roche. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    let caUsers: String = "Users"
    var users: [Users] = []
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 94.0, height: 124.0)
        layout.minimumInteritemSpacing = 20.5
        layout.sectionInset = UIEdgeInsets(top: 9, left: 20.5, bottom: 9, right: 20.5)
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collection: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = UIColor.white
        collection.delegate = self
        collection.dataSource = self
        collection.register(UserCell.self, forCellWithReuseIdentifier: String(describing: UserCell.self))
        return collection
    }()
    
    
    // MARK: Init
    
    override func loadView() {
        /// Esto no lo entiendo muy bien. ¿Por que la view, que en teoria ya es la de self, se le asigna algo vacio? -.-
        view = UIView()
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func viewDidLoad() {   
        super.viewDidLoad()
        
        self.title = caUsers
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.white246
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
                                                                        NSAttributedString.Key.font: UIFont.style34Bold]
        
        /// Recuperamos los datos del collection
        getData()
    }
    
    
    // MARK: Functions

    fileprivate func getData() {
        /// Con el objeto DataProvider accedemos a las funciones del API
        let dataProvider: DataProvider = DataProvider()
        dataProvider.userListAPIDiscourseRequest { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.users = response
                self.collectionView.reloadData()
                
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


// MARK: UICollectionView Delegate

extension UsersViewController: UICollectionViewDelegate {
    /// Funcion delegada para la seleccion de un item del Collection
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userDetailViewController: UserDetailViewController = UserDetailViewController.init(user: users[indexPath.row].user)
        let navigationController: UINavigationController = UINavigationController.init(rootViewController: userDetailViewController)
        navigationController.modalPresentationStyle = .formSheet
        navigationController.navigationBar.isHidden = true
        self.present(navigationController, animated: true, completion: nil)
        /// Deseleccionamos el item
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
    

// MARK: UICollectionView DataSource

extension UsersViewController: UICollectionViewDataSource {
    /// Funcion delegada del numero de items del Collection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    /// Funcion delegada de llenado del Collection
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: UserCell.self), for: indexPath) as? UserCell {
            cell.configureCell(user: users[indexPath.row].user)
            return cell
        }
        fatalError("Couldn't create cells")
    }
}
