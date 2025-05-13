//
//  HomeViewModel.swift
//  iosApp
//
//  Created by Eslam Ghazy on 4/4/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import ComposeApp

class HomeViewModel : ObservableObject {
    private var mainViewModel = ViewModel()
    @Published var state = HomeState()
 
    
    func getProviders(){
        mainViewModel.providerList { response in
            response.handleState {
                self.state.isLoading = true
                self.state.showError = false
                self.state.error = ""
            } onSuccess: { providerList in
                self.state.isLoading = false
                self.state.showError = false
                self.state.error = ""
                self.state.providerResponseState = providerList
            } onError: { error in
                self.state.isLoading = false
                self.state.showError = true
                self.state.error = error
            }
        }
    }
    
    func categories(){
        mainViewModel.categoryList { response in
            response.handleState {
                self.state.isLoading = true
                self.state.showError = false
                self.state.error = ""
            } onSuccess: { categoriesList in
                self.state.isLoading = false
                self.state.showError = false
                self.state.error = ""
                self.state.categoryResponseState = categoriesList
            } onError: { error in
                self.state.isLoading = false
                self.state.showError = true
                self.state.error = error
            }

        }
    }
    
    func servies(){
        mainViewModel.serviceList { response in
            response.handleState {
                self.state.isLoading = true
                self.state.showError = false
                self.state.error = ""
            } onSuccess: { serviceList in
                self.state.isLoading = false
                self.state.showError = false
                self.state.error = ""
                self.state.serviceResponseState = serviceList
            } onError: { error in
                self.state.isLoading = false
                self.state.showError = true
                self.state.error = error
            }
        }
    }
    
    func getAds(){
        mainViewModel.getAdv { response in
            response.handleState {
                self.state.isLoading = true
                self.state.showError = false
                self.state.error = ""
            } onSuccess: { advertisementList in
                self.state.isLoading = false
                self.state.showError = false
                self.state.error = ""
                self.state.advResponseState = advertisementList
            } onError: { error in
                self.state.isLoading = false
                self.state.showError = true
                self.state.error = error
            }
        }
    }
    
    func serviceFilter(_ id:Int32){
        mainViewModel.serviceFilter(
            filterService:FilterService(
                category_id: [KotlinInt(int: id)],
                city_id: [],
                provider: [],
                from_price: 1,
                to_price: 60000,
                currency_id: [],
                search_input: "")
        ) { response in
            response.handleState {
                self.state.isLoading = true
                self.state.showError = false
                self.state.error = ""
            } onSuccess: { filterList in
                self.state.isLoading = false
                self.state.showError = false
                self.state.error = ""
                self.state.filterServiceResponseState = filterList
            } onError: { error in
                self.state.isLoading = false
                self.state.showError = true
                self.state.error = error
            }
        }
    }
}
