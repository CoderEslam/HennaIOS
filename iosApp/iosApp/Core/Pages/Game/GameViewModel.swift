//
//  GameViewModel.swift
//  iosApp
//
//  Created by Eslam Ghazy on 3/4/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import ComposeApp

class GameViewModel : ObservableObject {
    
    @Published var state = GameState()
    private let mainViewModel: ViewModel = ViewModel()
    
    func showUser(completion: @escaping (RequestState<UserModel>) -> Void){
        mainViewModel.showUser { response in
            completion(response)
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
                self.state.showError = false
                self.state.error = error
            }
        }
    }
    
    func providerList(completion: @escaping (RequestState<RandomProvider>) -> Void){
        mainViewModel.providerRandomList { response in
            completion(response)
            response.handleState {
                self.state.isLoading = true
                self.state.showError = false
                self.state.error = ""
            } onSuccess: { providerList in
                self.state.isLoading = false
                self.state.showError = false
                self.state.error = ""
                self.state.providerList = providerList
                print("All Provider random -> \(providerList)")
            } onError: { error in
                self.state.isLoading = false
                self.state.showError = false
                self.state.error = error
            }
        }
    }
    
    
}
