//
//  UsersViewController.swift
//  AppDiscourseDesigned
//
//  Created by APPLE on 22/05/2020.
//  Copyright © 2020 Javier Roche. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    var users: [Users] = []
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let numberOfColumns: CGFloat = 3.0
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        //let width: CGFloat = (UIScreen.main.bounds.width - sectionInsetX*2 - minInteritemSpacing * (CGFloat(numberOfColumns) - 1)) / CGFloat(numberOfColumns)
        
//        94 =  373 - [ x * 0.6666 ]
//        (94 - 373/ 0.666  =  x
        
        layout.itemSize = CGSize(width: 94.0, height: 124.0)
        layout.minimumInteritemSpacing = 20.5
        layout.sectionInset = UIEdgeInsets(top: 9, left: 20.5, bottom: 9, right: 20.5)
        
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collection: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = UIColor.white
        collection.dataSource = self
        collection.register(UserCell.self, forCellWithReuseIdentifier: "UserCell")
        return collection
    }()
    
    override func loadView() {
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
        
        self.title = "Users"
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


// MARK: DataSource

extension UsersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: UserCell.self), for: indexPath) as? UserCell {
            cell.configureCell(user: users[indexPath.row].user)
            return cell
        }
        fatalError("Couldn't create cells")
    }
}
