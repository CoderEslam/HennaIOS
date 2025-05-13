//
//  AddNewService.swift
//  iosApp
//
//  Created by Eslam Ghazy on 27/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation
import ComposeApp
import Alamofire

class AddNewService {
    
    private let userDateViewModel: UserDataViewModel = UserDataViewModel()
    
    func uploadNewService(
        name: String,
        description: String,
        maxPrice: String,
        minPrice: String,
        categoryId: String,
        providerId: String,
        currencyId: String,
        imagesData: [Data]?,
        progressHandler: @escaping (Double) -> Void,
        completion: @escaping (RequestState<String>) -> Void
    ) {
        completion(.loading)
        
        // Define headers with Authorization token
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(userDateViewModel.getUserNormal().device_token ?? "")",
            "Content-Type": "multipart/form-data",
            "Accept": "application/json"
        ]
        
        // Alamofire upload request
        AF.upload(multipartFormData: { multipartFormData in
            // Add name, type, and description to the form data
            multipartFormData.append(
                name.data(using: .utf8) ?? Data(),
                withName: "name"
            )
            multipartFormData.append(
                description.data(using: .utf8) ?? Data(),
                withName: "description"
            )
            multipartFormData.append(
                maxPrice.data(using: .utf8) ?? Data(),
                withName: "max_price"
            )
            multipartFormData.append(
                minPrice.data(using: .utf8) ?? Data(),
                withName: "min_price"
            )
            multipartFormData.append(
                categoryId.data(using: .utf8) ?? Data(),
                withName: "category_id"
            )
            multipartFormData.append(
                providerId.data(using: .utf8) ?? Data(),
                withName: "provider_id"
            )
            multipartFormData.append(
                currencyId.data(using: .utf8) ?? Data(),
                withName: "currency_id"
            )
            
            
            // Add each image data to the multipart form
            if let images = imagesData {
                for (index, imageData) in images.enumerated() {
                    multipartFormData.append(
                        imageData,
                        withName: "images[\(index)]", // Array notation for multiple images
                        fileName: "image\(index + 1).png",
                        mimeType: "image/jpeg"
                    )
                }
            }
        }, to: Constants().SERVICES, method: .post, headers: headers)
        .uploadProgress { progress in
            // Report the upload progress
            progressHandler(progress.fractionCompleted)
        }
        .response { response in
            switch response.result {
            case .success(let data):
                if let data = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            print("Decoded JSON: \(json)")
                            if let success = json["success"] as? Bool {
                                print("Success: \(success)")
                            }
                            if let message = json["message"] as? String {
                                print("Message: \(message)")
                                completion(.success("\(message)"))
                            }
                        }
                        if let jsonString = String(data: data, encoding: .utf8) {
                            print("Raw JSON String: \(jsonString)")
                        }
                    } catch {
                        print("Failed to decode JSON: \(error.localizedDescription)")
                        completion(.error("JSON decoding error: \(error.localizedDescription)"))
                    }
                }
            case .failure(let error):
                completion(.error("Upload failed with error: \(error.localizedDescription)"))
            }
        }
    }
    
    
    func updateService(
        idService: String,
        name: String,
        description: String,
        maxPrice: String,
        minPrice: String,
        categoryId: String,
        providerId: String,
        currencyId: String,
        imagesData: [Data]?,
        progressHandler: @escaping (Double) -> Void,
        completion: @escaping (RequestState<String>) -> Void
    ) {
        completion(.loading)
        // Define headers with Authorization token
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(userDateViewModel.getUserNormal().device_token ?? "")",
            "Content-Type": "multipart/form-data",
            "Accept": "application/json"
        ]
        
        // Alamofire upload request
        AF.upload(multipartFormData: { multipartFormData in
            // Add name, type, and description to the form data
            multipartFormData.append(
                name.data(using: .utf8) ?? Data(),
                withName: "name"
            )
            multipartFormData.append(
                description.data(using: .utf8) ?? Data(),
                withName: "description"
            )
            multipartFormData.append(
                maxPrice.data(using: .utf8) ?? Data(),
                withName: "max_price"
            )
            multipartFormData.append(
                minPrice.data(using: .utf8) ?? Data(),
                withName: "min_price"
            )
            multipartFormData.append(
                categoryId.data(using: .utf8) ?? Data(),
                withName: "category_id"
            )
            multipartFormData.append(
                providerId.data(using: .utf8) ?? Data(),
                withName: "provider_id"
            )
            multipartFormData.append(
                currencyId.data(using: .utf8) ?? Data(),
                withName: "currency_id"
            )
            multipartFormData.append(
                "PUT".data(using: .utf8) ?? Data(),
                withName: "_method"
            )
            
            
            // Add each image data to the multipart form
            if let images = imagesData {
                for (index, imageData) in images.enumerated() {
                    multipartFormData.append(
                        imageData,
                        withName: "images[\(index)]", // Array notation for multiple images
                        fileName: "image\(index + 1).png",
                        mimeType: "image/jpeg"
                    )
                }
            }
        }, to: Constants().UPDATE_SERVICE_BY_ID + idService, method: .post, headers: headers)
        .uploadProgress { progress in
            // Report the upload progress
            progressHandler(progress.fractionCompleted)
        }
        .response { response in
            switch response.result {
            case .success(let data):
                if let data = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            print("Decoded JSON: \(json)")
                            if let success = json["success"] as? Bool {
                                print("Success: \(success)")
                            }
                            if let message = json["message"] as? String {
                                print("Message: \(message)")
                                completion(.success("\(message)"))
                            }
                        }
                        if let jsonString = String(data: data, encoding: .utf8) {
                            print("Raw JSON String: \(jsonString)")
                        }
                    } catch {
                        print("Failed to decode JSON: \(error.localizedDescription)")
                        completion(.error("JSON decoding error: \(error.localizedDescription)"))
                    }
                }
            case .failure(let error):
                completion(.error("Upload failed with error: \(error.localizedDescription)"))
            }
        }
    }
    
}
