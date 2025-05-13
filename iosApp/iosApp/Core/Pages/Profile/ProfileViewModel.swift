//
//  ProfileViewModel.swift
//  iosApp
//
//  Created by Eslam Ghazy on 3/4/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import SwiftUI
import ComposeApp

class ProfileViewModel : ObservableObject {
    
    private var mainViewModel = ViewModel()
    private var userDataViewModel = SettingsViewModel()
    private let uploadingImage = UploadingImageService()
    @Published var state = ProfileState()
    
    func onEvent(_ event:ProfileEvent){
        switch event {
        case .imageSelectable(let userImage):
            state.imageSelectable = userImage
        }
    }
    
    private func uploadImageUser(imageData: Data, progressHandler: @escaping (Double) -> Void, completion: @escaping (RequestState<String>) -> Void) {
        uploadingImage.uploadImageUser(imageData: imageData, progressHandler: { p in
            progressHandler(p)
        }, completion: { response in
            completion(response)
        })
    }
    
    private func uploadImageUserBackground(imageData: Data ,progressHandler: @escaping (Double) -> Void, completion: @escaping (RequestState<String>) -> Void) {
        uploadingImage.uploadImageUserBackground(imageData: imageData,progressHandler: { p in
            progressHandler(p)
        }) { response in
            completion(response)
        }
    }
    
    
    func uploadUserImage(_ image: UIImage) {
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
                self.state.isLoading = true
                self.state.showError = false
                self.state.error = ""
            } onSuccess: { data in
                self.state.isLoading = false
                self.state.showError = true
                self.state.error = data
            } onError: { error in
                self.state.isLoading = false
                self.state.showError = true
                self.state.error = error
            }
        }
    }
    
    func uploadUserBgImage(_ image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.1) else {
            print("Failed to convert image to data")
            return
        }
        //updateImageViewModel.uploadToBackend(imageData: imageData)
        // Call the Alamofire upload method
        uploadImageUserBackground(imageData: imageData , progressHandler: { p in
            print("\(p)")
        }) { response in
            response.handleState {
                self.state.isLoading = true
                self.state.showError = false
                self.state.error = ""
            } onSuccess: { data in
                self.state.isLoading = false
                self.state.showError = true
                self.state.error = data
            } onError: { error in
                self.state.isLoading = false
                self.state.showError = true
                self.state.error = error
            }
        }
    }
    
    func showUser(){
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
    
    func showProvider(){
        mainViewModel.showProviderById(id: userDataViewModel.getProviderId()) { response in
            response.handleState {
                self.state.isLoading = true
                self.state.showError = false
                self.state.error = ""
            } onSuccess: { providerModelData in
                self.state.isLoading = false
                self.state.showError = false
                self.state.error = ""
                self.state.providerModelData = providerModelData
            } onError: { error in
                self.state.isLoading = false
                self.state.showError = true
                self.state.error = error
            }
        }
    }
  
    
}
