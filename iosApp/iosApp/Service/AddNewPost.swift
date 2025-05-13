//
//  AddNewPost.swift
//  iosApp
//
//  Created by Eslam Ghazy on 3/12/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation
import ComposeApp
import Alamofire

class AddNewPost {
    
    private let userDateViewModel: UserDataViewModel = UserDataViewModel()
    
    
    
    func uploadNewPost(
        description: String,
        type: String,
        content: Data?,
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
                description.data(using: .utf8) ?? Data(),
                withName: "description"
            )
            multipartFormData.append(
                type.data(using: .utf8) ?? Data(),
                withName: "type"
            )
            if let content = content {
                multipartFormData.append(
                    content,
                    withName: "content",
                    fileName: "content",
                    mimeType: "image/jpeg"
                )
            }
        }, to: Constants().SET_POST, method: .post, headers: headers)
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
