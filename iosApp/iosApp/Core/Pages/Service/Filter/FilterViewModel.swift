//
//  FilterViewModel.swift
//  iosApp
//
//  Created by Eslam Ghazy on 4/4/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import ComposeApp

class FilterViewModel : ObservableObject {
    
    private var mainViewModel = ViewModel()
    @Published var state = FilterState()
    
    
    
    func getCategories(){
        mainViewModel.categoryList { response in
            response.handleState {
                self.state.isLoading = true
                self.state.showError = false
                self.state.error = ""
            } onSuccess: { categoriesList in
                self.state.isLoading = false
                self.state.showError = false
                self.state.error = ""
                self.state.categoryList = categoriesList
            } onError: { error in
                self.state.isLoading = false
                self.state.showError = true
                self.state.error = error
            }
        }
       
        
    }
    
    func getCountries(){
        mainViewModel.countries { response in
            response.handleState {
                self.state.isLoading = true
                self.state.showError = false
                self.state.error = ""
            } onSuccess: { countriesList in
                self.state.isLoading = false
                self.state.showError = false
                self.state.error = ""
                self.state.countryList = countriesList
            } onError: { error in
                self.state.isLoading = false
                self.state.showError = true
                self.state.error = error
            }
        }
    }
    
    func getCurrency(){
        mainViewModel.getCurrency { response in
            response.handleState {
                self.state.isLoading = true
                self.state.showError = false
                self.state.error = ""
            } onSuccess: { currenciesList in
                self.state.isLoading = false
                self.state.showError = false
                self.state.error = ""
                self.state.currencyList = currenciesList
            } onError: { error in
                self.state.isLoading = false
                self.state.showError = true
                self.state.error = error
            }
        }
    }
    
    func filter(){
        mainViewModel.serviceFilter(filterService: FilterService(
            category_id: [KotlinInt(int: Int32(truncating: self.state.selectedItemCategory?.id ?? -1))],
            city_id: [KotlinInt(int: Int32(truncating: self.state.selectedItemCity?.id ?? -1))],
            provider: [],
            from_price: 500, to_price: 30000,
            currency_id: [KotlinInt(int: Int32(truncating: self.state.selectedItemCurrency?.id ?? -1))],
            search_input: ""))
        { response in
            response.handleState {
                self.state.isLoading = true
                self.state.showError = false
                self.state.error = ""
            } onSuccess: { filterList in
                self.state.isLoading = false
                self.state.showError = false
                self.state.error = ""
                self.state.filterList = filterList
                self.state.showFilterResult = true
            } onError: { error in
                self.state.isLoading = false
                self.state.showError = true
                self.state.error = error
            }
        }
    }
    
    
}
