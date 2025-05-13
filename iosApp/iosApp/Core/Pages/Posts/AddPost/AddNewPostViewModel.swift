//
//  AddNewPostViewModel.swift
//  iosApp
//
//  Created by Eslam Ghazy on 3/12/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation


class AddNewPostViewModel : ObservableObject {
    
    private let mainViewModel: ViewModel = ViewModel()
    private let addNewPost = AddNewPost()
    @Published var state = AddPostState()
    
    func onEvent(_ event:AddPostEvent) {
        switch (event) {
        case .type(let type):
            self.state.type = type.rawValue
        case .data(let content):
            self.state.content = content
        }
    }
    
    func uploadNewPost(
        progressHandler: @escaping (Double) -> Void,
        completion: @escaping (RequestState<String>) -> Void
    ) {
        addNewPost.uploadNewPost(
            description: self.state.description,
            type: self.state.type,
            content: self.state.content
        ) { p in
            progressHandler(p)
        } completion: { response in
            completion(response)
        }
    }
    
    func showUser(){
        mainViewModel.showUser { response in
            response.handleState {
                self.state.isLoading = true
                self.state.showError = false
                self.state.error = ""
            } onSuccess: { userModel in
                self.state.userModel = userModel
                self.state.isLoading = false
                self.state.showError = false
                self.state.error = ""
            } onError: { error in
                self.state.isLoading = false
                self.state.showError = true
                self.state.error = error
            }

        }
    }
    
    
}
