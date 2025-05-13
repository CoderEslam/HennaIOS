//
//  NetworkingManager.swift
//  iosApp
//
//  Created by Eslam Ghazy on 7/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import Alamofire

class NetworkingManager {
    private static let TAG = "NetworkingManager"
    @AppStorage("token") static var token: String = ""
    
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL, message: String)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(_, let message):
                return message
            case .unknown:
                return "Unknown error occurred"
            }
        }
    }
    
    // Method for downloading (GET request)
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json"
        ]
        
        return Future<Data, Error> { promise in
            AF.request(url, method: .get, headers: headers)
                .validate(statusCode: 200..<300)
                .responseString { response in
                    switch response.result {
                    case .success(let data):
                        promise(.success(Data(data.utf8)))
                    case .failure(let error):
                        let responseBody = response.data.flatMap { String(data: $0, encoding: .utf8) } ?? "Unknown error"
                        promise(.failure(NetworkingError.badURLResponse(url: url, message: responseBody)))
                    }
                }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    static func downloadImage(url:URL) -> AnyPublisher<Data,Error> {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(self.token)", forHTTPHeaderField: "Authorization")
        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap ({ try handleURLResponse(output: $0,url: url) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    // Method for uploading (POST request)
    static func upload(url: URL, jsonData: Data) -> AnyPublisher<Data, Error> {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json"
        ]
        return Future<Data, Error> { promise in
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = jsonData  // Set the JSON data directly as the request body
            request.headers = headers
            AF.request(request)
                .validate(statusCode: 200..<300)
                .responseString { response in
                    switch response.result {
                    case .success(let data):
                        promise(.success(Data(data.utf8)))  // Convert string to Data
                    case .failure:
                        let responseBody = response.data.flatMap { String(data: $0, encoding: .utf8) } ?? "Unknown error"
                        promise(.failure(NetworkingError.badURLResponse(url: url, message: responseBody)))
                    }
                }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    
    static func update(url: URL, jsonData: Data) -> AnyPublisher<Data, Error> {
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(self.token)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData
        
        return Future { promise in
            AF.request(request)
                .validate()
                .response { response in
                    switch response.result {
                    case .success(let data):
                        if let data = data {
                            promise(.success(data))
                        } else {
                            promise(.failure(NetworkingError.unknown))
                        }
                    case .failure(let afError):
                        let statusCode = response.response?.statusCode ?? 0
                        let responseString = String(data: response.data ?? Data(), encoding: .utf8) ?? "Unknown error"
                        if statusCode != 200 {
                            promise(.failure(NetworkingError.badURLResponse(url: url, message: responseString)))
                        } else {
                            promise(.failure(afError))
                        }
                    }
                }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    // Handle DELETE requests similarly
    static func delete(url: URL) -> AnyPublisher<Data, Error> {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json"
        ]
        
        return Future<Data, Error> { promise in
            AF.request(url, method: .delete, headers: headers)
                .validate(statusCode: 200..<300)
                .responseString { response in
                    switch response.result {
                    case .success(let data):
                        promise(.success(Data(data.utf8)))
                    case .failure(let error):
                        let responseBody = response.data.flatMap { String(data: $0, encoding: .utf8) } ?? "Unknown error"
                        promise(.failure(NetworkingError.badURLResponse(url: url, message: responseBody)))
                    }
                }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    static func handleCompletion(compeletion : Subscribers.Completion<Error>){
        switch compeletion {
        case .finished:
            break
        case .failure(let error):
            print("\(TAG) \(error.localizedDescription)")
        }
        
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse else {
            throw NetworkingError.unknown
        }
        
        if response.statusCode >= 200 && response.statusCode < 300 {
            return output.data
        } else {
            let responseMessage = String(data: output.data, encoding: .utf8) ?? "Unknown error"
            throw NetworkingError.badURLResponse(url: url, message: responseMessage)
        }
    }
}
