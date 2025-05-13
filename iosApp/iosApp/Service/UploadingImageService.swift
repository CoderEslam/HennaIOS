//
//  UploadingImageService.swift
//  iosApp
//
//  Created by Eslam Ghazy on 25/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation
import Alamofire
import ComposeApp

class UploadingImageService {
    
    
    private let userDateViewModel: UserDataViewModel = UserDataViewModel()
    
    func uploadImageUser(imageData: Data, progressHandler: @escaping (Double) -> Void, completion: @escaping (RequestState<String>) -> Void) {
        completion(.loading)
        
        // Define headers with Authorization token
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(userDateViewModel.getUserNormal().device_token ?? "")",
            "Content-Type": "multipart/form-data",
            "Content-Type" : "application/json",
            "Accept": "application/json"
        ]
        
        // Alamofire upload request
        AF.upload(multipartFormData: { multipartFormData in
            // Add image data to multipart form
            multipartFormData.append(imageData, withName: "image", fileName: "image.png", mimeType: "image/jpeg")
        }, to: Constants().UPDATE_USER_IMAGE, method: .post, headers: headers)
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
                            }
                            if let imageUrl = json["imageUrl"] as? String {
                                print("Image URL: \(imageUrl)")
                            }
                        }
                        if let jsonString = String(data: data, encoding: .utf8) {
                            print("Raw JSON String: \(jsonString)")
                        }
                    } catch {
                        print("Failed to decode JSON: \(error.localizedDescription)")
                    }
                    completion(.success("Image uploaded successfully: \(data)"))
                }
            case .failure(let error):
                completion(.error("Upload failed with error: \(error)"))
            }
        }
    }
    
    func uploadImageUserBackground(imageData: Data , progressHandler: @escaping (Double) -> Void, completion: @escaping (RequestState<String>) -> Void) {
        completion(.loading)
        
        // Define headers with Authorization token
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(userDateViewModel.getUserNormal().device_token ?? "")",
            "Content-Type": "multipart/form-data",
            "Content-Type" : "application/json",
            "Accept": "application/json"
        ]
        
        // Alamofire upload request
        AF.upload(multipartFormData: { multipartFormData in
            // Add image data to multipart form
            multipartFormData.append(imageData, withName: "bg_image", fileName: "image.png", mimeType: "image/jpeg")
        }, to: Constants().UPDATE_USER_BACKGROUND_IMAGE, method: .post, headers: headers)
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
                            }
                            if let imageUrl = json["imageUrl"] as? String {
                                print("Image URL: \(imageUrl)")
                            }
                        }
                        if let jsonString = String(data: data, encoding: .utf8) {
                            print("Raw JSON String: \(jsonString)")
                        }
                    } catch {
                        print("Failed to decode JSON: \(error.localizedDescription)")
                    }
                    completion(.success("Image uploaded successfully: \(data)"))
                }
            case .failure(let error):
                completion(.error("Upload failed with error: \(error)"))
            }
        }
    }
    
    
}
