//
//  DataProvider.swift
//  AppDiscourseDesigned
//
//  Created by APPLE on 22/05/2020.
//  Copyright © 2020 Javier Roche. All rights reserved.
//

import Foundation

class DataProvider {
    let caLatestTopicsURLDomain: String = "https://mdiscourse.keepcoding.io/"
    let caUserListURLDomain: String = "https://mdiscourse.keepcoding.io/directory_items.json?period=all&order=topics_entered"
    let caGET: String = "GET"
    let caAPIKeyValue: String = "699667f923e65fac39b632b0d9b2db0d9ee40f9da15480ad5a4bcb3c1b095b7a"
    let caAPIKey: String = "Api-Key"
    let caAPIUsernameValue: String = "Tushe"
    let caAPIUsername: String = "Api-Username"
    let caContentTypeValue: String = "application/json"
    let caContentType: String = "Content-Type"
    
    
    func latestTopicsAPIDiscourse(completion: @escaping (Result<LatestTopicsResponse, Error>) -> (Void)) {
        /// Creamos la URL utilizando el constructor con string, capturamos el posible error
        guard let topicsURL: URL = URL(string: "\(caLatestTopicsURLDomain)latest.json") else {
            completion(.failure(ErrorTypes.malformedURL))
            return
        }
        
        /// Creamos la request y le asignamos los valores necesarios del API
        var request: URLRequest = URLRequest(url: topicsURL)
        request.httpMethod = caGET
        request.addValue(caAPIKeyValue, forHTTPHeaderField: caAPIKey)
        request.addValue(caAPIUsernameValue, forHTTPHeaderField: caAPIUsername)
        request.addValue(caContentTypeValue, forHTTPHeaderField: caContentType)
        
        /// Creamos la URLSession con una URLSessionConfiguracion por defecto
        let configuration: URLSessionConfiguration = URLSessionConfiguration.default
        let session: URLSession = URLSession(configuration: configuration)
        
        /// La session lanza su URLSessionDatatask con la request
        let dataTask: URLSessionDataTask = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            /// Si ha habido respuesta y la podemos recibir como HTTPURLResponse y ademas hay datos
            if let response = response as? HTTPURLResponse, let data = data {
                print("statusCode \(response.statusCode)")
                /// Devolvemos el array que contiene los topics recuperados
                if response.statusCode == 200 {
                    do {
                        let response = try JSONDecoder().decode(LatestTopicsResponse.self, from: data)
                        DispatchQueue.main.async {
                            completion(.success(response))
                        }
                        
                    /// Devolvemos el tipo Error para la no decodificacion de la response
                    } catch {
                        DispatchQueue.main.async {
                            completion(.failure(ErrorTypes.malformedData))
                        }
                    }
                
                /// Devolvemos el tipo Error de respuesta
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(ErrorTypes.statusCode))
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    
    func userListAPIDiscourseRequest(completion: @escaping (Result<[Users], Error>) -> (Void)) {
        /// Creamos la URL utilizando el constructor con string, capturamos el posible error
        guard let topicsURL: URL = URL(string: caUserListURLDomain) else {
            DispatchQueue.main.async {
                completion(.failure(ErrorTypes.malformedURL))
            }
            return
        }
    
        /// Creamos la request y le asignamos los valores necesarios del API
        var request: URLRequest = URLRequest(url: topicsURL)
        request.httpMethod = caGET
        request.addValue(caAPIKeyValue, forHTTPHeaderField: caAPIKey)
        request.addValue(caAPIUsernameValue, forHTTPHeaderField: caAPIUsername)
        request.addValue(caContentTypeValue, forHTTPHeaderField: caContentType)
        
        /// Creamos la URLSession con una URLSessionConfiguracion por defecto
        let configuration: URLSessionConfiguration = URLSessionConfiguration.default
        let session: URLSession = URLSession(configuration: configuration)
        
    
        let dataTask: URLSessionDataTask = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
                
            /// Si ha habido respuesta y la podemos recibir como HTTPURLResponse y ademas hay datos
            if let response = response as? HTTPURLResponse, let data = data {
                print("Users Status Code: \(response.statusCode)")
                /// Devolvemos el array que contiene los users recuperados
                if response.statusCode == 200 {
                    do {
                        let response = try JSONDecoder().decode(UsersDirectoryResponse.self, from: data)
                        DispatchQueue.main.async {
                            completion(.success(response.directoryItems))
                        }
                        
                    /// Devolvemos el tipo Error para la no decodificacion de la response
                    } catch {
                        DispatchQueue.main.async {
                            completion(.failure(ErrorTypes.malformedData))
                        }
                    }
                    
                /// Devolvemos el tipo Error de respuesta
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(ErrorTypes.statusCode))
                    }
                }
            }
        }
        dataTask.resume()
    }
    
//    func singleUserAPIDiscourse(username: String, completion: @escaping (Result<User, Error>) -> Void) {
//        print("singleUserAPIDiscourse")
//        /// Creamos la URL utilizando el constructor con string, capturamos el posible error
//        guard let discourseURL: URL = URL(string: "\(caDiscourseURLDomain)users/\(username).json") else {
//            completion(.failure(ErrorTypes.malformedURL))
//            return
//        }
//
//        /// Creamos la request y le asignamos los valores necesarios del API
//        var request: URLRequest = URLRequest(url: discourseURL)
//        request.httpMethod = caGET
//        request.addValue(caAPIKeyValue, forHTTPHeaderField: caAPIKey)
//        request.addValue(caAPIUsernameValue, forHTTPHeaderField: caAPIUsername)
//        request.addValue(caContentTypeValue, forHTTPHeaderField: caContentType)
//
//        /// Creamos la URLSession con una URLSessionConfiguracion por defecto
//        let configuration: URLSessionConfiguration = URLSessionConfiguration.default
//        let session: URLSession = URLSession.init(configuration: configuration)
//
//        /// La session lanza su URLSessionDatatask con la request
//        let dataTask: URLSessionDataTask = session.dataTask(with: request) { (data, response, error) in
//            print("1")
//            if let error = error {
//                print("2")
//                DispatchQueue.main.async {
//                    completion(.failure(error))
//                }
//            }
//
//            /// Si ha habido respuesta y la podemos recibir como HTTPURLResponse y ademas hay datos
//            if let response = response as? HTTPURLResponse, let data = data {
//                print("statusCode \(response.statusCode)")
//                /// Devolvemos el array que contiene los topics recuperados
//                if response.statusCode == 200 {
//                    do {
//                        let response = try JSONDecoder().decode(SingleUserResponse.self, from: data)
//                        DispatchQueue.main.async {
//                            completion(.success(response.user))
//                        }
//
//                    } catch {
//                        /// Devolvemos el tipo Error para la no decodificacion de la response
//                        DispatchQueue.main.async {
//                            completion(.failure(ErrorTypes.malformedData))
//                        }
//                    }
//
//                } else {
//                    DispatchQueue.main.async {
//                        completion(.failure(ErrorTypes.statusCode))
//                    }
//                }
//            }
//        }
//        dataTask.resume()
//    }
}
