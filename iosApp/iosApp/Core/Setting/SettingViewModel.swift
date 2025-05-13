//
//  SettingViewModel.swift
//  iosApp
//
//  Created by Eslam Ghazy on 1/4/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import ComposeApp
import SwiftUI

class SettingViewModel :ObservableObject {
    
    private var mainViewModel = ViewModel()
    private var userData = SettingsViewModel()
    private let uploadingImage = UploadingImageService()
    
    @Published var state = SettingState()
    
    func onEvent(_ event : SettingEvent){
        switch event {
        case .openEditProfile(let open):
            state.openEditProfile = open
        case .openImagePicker(let open):
            state.openImagePicker = open
        case .selectedImage(let image):
            state.selectedImage = image
        case .selectedImageData(let data):
            state.selectedImageData = data
        case .auth(let auth):
            state.goToAuth = auth
        }
    }
    
    
    func uploadImageUser(
        imageData: Data,
        progressHandler: @escaping (Double) -> Void,
        completion: @escaping (RequestState<String>) -> Void
    ) {
        uploadingImage.uploadImageUser(imageData: imageData, progressHandler: { p in
            progressHandler(p)
        }, completion: { response in
            completion(response)
        })
    }
    
    func uploadImageUserBackground(
        imageData: Data ,
        progressHandler: @escaping (Double) -> Void,
        completion: @escaping (RequestState<String>) -> Void
    ) {
        uploadingImage.uploadImageUserBackground(imageData: imageData,progressHandler: { p in
            progressHandler(p)
        }) { response in
            completion(response)
        }
    }
    
    func loadUserData() {
        mainViewModel.showUser { response in
            response.handleState {
                self.state.isLoading = true
                self.state.showError = false
                self.state.error = ""
            } onSuccess: { userModel in
                self.state.isLoading = false
                self.state.showError = false
                self.state.error = ""
                self.state.userModel = userModel
            } onError: { error in
                self.state.isLoading = false
                self.state.showError = true
                self.state.error = error
            }
        }
    }
    
    func uploadImage(_ image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.1) else {
            print("Failed to convert image to data")
            return
        }
        //updateImageViewModel.uploadToBackend(imageData: imageData)
        // Call the Alamofire upload method
        uploadImageUser(imageData: imageData , progressHandler: { p in
            print("\(p)")
        }) { response in
            response.handleState {
                //loading
                print("IMAGEESLAM Loading...")
                self.state.isLoading = true
                self.state.showError = false
            } onSuccess: { data in
                print("IMAGEESLAM \(data)")
                self.state.isLoading = false
                self.state.showError = false
            } onError: { error in
                self.state.isLoading = false
                self.state.error = error
                self.state.showError = true
                print("IMAGEESLAM \(error)")
            }
            
        }
    }
    
    func logout(){
        userData.logout()
        state.goToAuth = true
    }
    
    
}
