//
//  FavoriteServiceViewModel.swift
//  iosApp
//
//  Created by Eslam Ghazy on 3/4/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation

class FavoriteServiceViewModel : ObservableObject {
    private var mainViewModel = ViewModel()
    @Published var state = FavoriteServiceState()
    
    
    
    func getFavoriteService(){
        mainViewModel.getFavoriteServices { response in
            response.handleState {
                self.state.isLoading = true
                self.state.showError = false
                self.state.error = ""
            } onSuccess: { favoriteServiceList in
                self.state.isLoading = false
                self.state.showError = false
                self.state.error = ""
                self.state.favoriteServiceList = favoriteServiceList
            } onError: { error in
                self.state.isLoading = false
                self.state.showError = true
                self.state.error = error
            }

        }
    }
    
}
