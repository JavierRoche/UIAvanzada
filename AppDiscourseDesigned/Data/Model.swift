//
//  Model.swift
//  AppDiscourseDesigned
//
//  Created by APPLE on 22/05/2020.
//  Copyright © 2020 Javier Roche. All rights reserved.
//

import UIKit


// MARK: Topics Response Model: Latest Topics

struct LatestTopicsResponse: Codable {
    let users: [User]
    let topicList: TopicList
    
    enum CodingKeys: String, CodingKey {
        case users = "users"
        case topicList = "topic_list"
    }
}

struct User: Codable {
    let id: Int
    let username: String
    let name: String?
    let avatarTemplate: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case username = "username"
        case name = "name"
        case avatarTemplate = "avatar_template"
    }
}

struct TopicList: Codable {
    let topics: [Topic]
}

struct Topic: Codable {
    let id: Int?
    let title: String?
    let postCount: Int?
    let lastPostedAt: String?
    let lastPosterUsername: String?
    let posters: [Poster]?
    var avatarURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case postCount = "posts_count"
        case lastPostedAt = "last_posted_at"
        case lastPosterUsername = "last_poster_username"
        case posters = "posters"
        case avatarURL = "avatar_template"
    }
}

struct Poster: Codable {}


// MARK: Users Response Model: User List

struct UsersDirectoryResponse: Codable {
    let directoryItems: [Users]
    enum CodingKeys: String, CodingKey {
        case directoryItems = "directory_items"
    }
}

struct Users: Codable {
    let user: User
}


// MARK: Error Response Model

enum ErrorTypes: Error {
    case statusCode
    case malformedURL
    case malformedData
    var description: String {
        switch self {
            case .statusCode: return "Status code failure"
            case .malformedURL: return "Malformed URL"
            case .malformedData: return "Couldn't decodable API response"
        }
    }
}


// MARK: UIViewController Personal Utilities

extension UIViewController {
    /// Funcion para la generacion de mensajes de alerta
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
