//
//  ProviderViewModel.swift
//  iosApp
//
//  Created by Eslam Ghazy on 4/4/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation

class ProviderViewModel : ObservableObject {
    
    private var mainViewModel = ViewModel()
    private var userData = SettingsViewModel()
    @Published var state = ProviderState()
    
    
    func providers(){
        mainViewModel.providerList { response in
            response.handleState {
                self.state.isLoading = true
                self.state.showError = false
                self.state.error = ""
            } onSuccess: { providerList in
                self.state.isLoading = false
                self.state.showError = false
                self.state.error = ""
                self.state.providerList = providerList
                self.state.prioviderModelList = providerList.data
            } onError: { error in
                self.state.isLoading = false
                self.state.showError = true
                self.state.error = error
            }

        }
    }
    
    func searchProvider(){
        mainViewModel.getProvidersSearch(search_input: state.search) { response in
            response.handleState {
                self.state.isLoading = true
                self.state.showError = false
                self.state.error = ""
            } onSuccess: { data in
                self.state.isLoading = false
                self.state.showError = false
                self.state.error = ""
                self.state.prioviderModelList = data.data
            } onError: { error in
                self.state.isLoading = false
                self.state.showError = true
                self.state.error = error
            }
        }
    }
    
    func showProviderById(_ id:Int){
        mainViewModel.showProviderById(id: id) { response in
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
    
    func getPostsByProviderId(_ id:Int32){
        mainViewModel.getPostsByProviderId(userId: id) { response in
            response.handleState {
                self.state.isLoading = true
                self.state.showError = false
                self.state.error = ""
            } onSuccess: { postsList in
                self.state.isLoading = false
                self.state.showError = false
                self.state.error = ""
                self.state.postsList = postsList
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
    
    func setPostLike(_ id:Int32){
        mainViewModel.setPostLike(postId: id) { response in
            response.handleState {
                self.state.isLoading = true
                self.state.showError = false
                self.state.error = ""
            } onSuccess: { post_ in
                self.state.isLoading = false
                self.state.showError = false
                self.state.error = ""
                self.state.post_ = post_
            } onError: { error in
                self.state.isLoading = false
                self.state.showError = true
                self.state.error = error
            }

        }
    }
    
    func dislikePost(_ id:Int32){
        mainViewModel.deletePostLike(postId: id) { response in
            response.handleState {
                self.state.isLoading = true
                self.state.showError = false
                self.state.error = ""
            } onSuccess: { post_ in
                self.state.isLoading = false
                self.state.showError = false
                self.state.error = ""
                self.state.post_ = post_
            } onError: { error in
                self.state.isLoading = false
                self.state.showError = true
                self.state.error = error
            }

        }
    }
    
}
