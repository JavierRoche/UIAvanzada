//
//  NewTopicViewController.swift
//  AppDiscourseDesigned
//
//  Created by APPLE on 28/05/2020.
//  Copyright © 2020 Javier Roche. All rights reserved.
//

import UIKit

class NewTopicViewController: UIViewController {
    let caViewTitle: String = "Create new topic"
    let caPost: String = "Post"
    let caCancel: String = "Cancel"
    
    convenience init() {
        self.init(nibName: String(describing: NewTopicViewController.self), bundle: nil)
        
        self.title = caViewTitle
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont.style17semibold]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Creacion del boton de cancelar y publicar
        let cancelLeftBarButtonItem: UIBarButtonItem = UIBarButtonItem(title: caCancel, style: .plain, target: self, action: #selector(cancel))
        cancelLeftBarButtonItem.tintColor = UIColor.tangerine
        navigationItem.leftBarButtonItem = cancelLeftBarButtonItem
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.style17regular], for: .normal)
        
        let postLeftBarButtonItem: UIBarButtonItem = UIBarButtonItem(title: caPost, style: .plain, target: self, action: #selector(postTopic))
        postLeftBarButtonItem.tintColor = UIColor.tangerine
        navigationItem.rightBarButtonItem = postLeftBarButtonItem
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.style17semibold], for: .normal)
    }
    
    
    // MARK: Functions
    
    @objc private func postTopic() {
        /// Habria implementado la creacion, el delegado para avisar y el repintado de la tabla pero era copiar pegar lo de la practica de Concurrencia
        /// Como iba de diseño he creado la pantalla por el diseño
    }
    
    @objc private func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
}
