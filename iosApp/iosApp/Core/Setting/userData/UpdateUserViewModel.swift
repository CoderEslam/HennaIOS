//
//  UpdateUserViewModel.swift
//  iosApp
//
//  Created by Eslam Ghazy on 1/4/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import ComposeApp

class UpdateUserViewModel : ObservableObject {
    
    private var mainViewModel = ViewModel()
    private var userDataViewModel = SettingsViewModel()
    @Published var state = UpdateUserState()
    
    init() {
        getCountries()
        getLanguages()
        showUser()
    }
    
    func onEvent(_ event:UpdateUserEvent){
        switch (event) {
        case .firstName(let name):
            state.firstName = name
        case .lastName(let name):
            state.lastName = name
        case .brandName(let brandName):
            state.brandName = brandName
        case .bio(let bio):
            state.bio = bio
        case .email(let email):
            state.email = email
        case .countryCode(let code):
            state.countryCode = code
        case .selectedCountry(let country):
            state.selectedCountry = country
        case .selectedItemCountry(let itemCountry):
            state.selectedItemCountry = itemCountry
        case .selectedItemProvince(let itemProvince):
            state.selectedItemProvince = itemProvince
        case .selectedItemCity(let itemCity):
            state.selectedItemCity = itemCity
        case .selectedItemLanguage(let itemLanguage):
            state.selectedItemLanguage = itemLanguage
        case .phone(let phone):
            state.phone = phone
        }
    }
    

    
    
    func getCountries(){
        mainViewModel.countries { response in
            response.handleState {
                self.state.isLoading = true
            } onSuccess: { countriesList in
                self.state.isLoading = false
                self.state.countriesList = countriesList.data ?? []
            } onError: { error in
                self.state.isLoading = false
                self.state.showError = true
                self.state.error = error
            }
        }
    }

    
    func getLanguages(){
        mainViewModel.languages { response in
            response.handleState {
                self.state.isLoading = true
            } onSuccess: { languagesList in
                self.state.isLoading = false
                self.state.languagesList = languagesList.data ?? []
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
            } onSuccess: { userModel in
                self.state.isLoading = false
                self.state.userModel = userModel
                self.state.firstName = userModel.data?.first_name ?? ""
                self.state.lastName = userModel.data?.last_name ?? ""
                self.state.phone = userModel.data?.phone ?? ""
                self.state.email = userModel.data?.email ?? ""
                self.state.countryCode = userModel.data?.phone_extension ?? ""
                self.state.interests = userModel.data?.interests ?? []
                self.state.selectedItemCountry = CountryModel(
                    id: userModel.data?.country?.id,
                    name: userModel.data?.country?.name,
                    provinces: userModel.data?.country?.provinces
                )
                self.state.selectedItemProvince = ProvincesModel(
                    cities: userModel.data?.province?.cities,
                    country_id: userModel.data?.country?.id,
                    id: userModel.data?.province?.id,
                    name: userModel.data?.province?.name
                )
                self.state.selectedItemCity = CityModel(
                    id: userModel.data?.city?.id,
                    name: userModel.data?.city?.name,
                    province_id: userModel.data?.city?.province_id
                )
                self.state.selectedItemLanguage = LanguagesModel(
                    id: userModel.data?.language?.id,
                    name: userModel.data?.language?.name,
                    prefix: userModel.data?.language?.prefix
                )
            } onError: { error in
                self.state.isLoading = false
                self.state.showError = true
                self.state.error = error
            }
        }
    }
    
    func updateUser(completion: @escaping () -> Void){
        updateProvider()
        mainViewModel.updateUser(
            updateUser: UpdateUser(
                first_name: self.state.firstName,
                last_name: self.state.lastName,
                phone: self.state.phone,
                email: self.state.email,
                phone_extension:self.state.selectedCountry?.dial_code ?? "",
                country_id: "\(self.state.selectedItemCountry?.id ?? -1)",
                province_id: "\(self.state.selectedItemProvince?.id ?? -1)",
                city_id: "\(self.state.selectedItemCity?.id ?? -1)",
                language_id: "\(self.state.selectedItemLanguage?.id ?? -1)",
                interests: self.state.interests.compactMap{$0.id},
                brand_name: "",
                provider_bio: "",
                registration_number: ""
            )
        ) { response in
            response.handleState {
                self.state.isLoading = true
            } onSuccess: { message in
                self.state.isLoading = false
                completion()
                print(message)
            } onError: { error in
                self.state.isLoading = false
                self.state.error = error
                self.state.showError = true
                print(error)
            }
        }
    }
    
    func updateProvider(){
        if userDataViewModel.getProvider() != nil {
            mainViewModel.updateProvider(
                id: "\(userDataViewModel.getProviderId())",
                updateProvider: UpdateProvider(
                    brand_name: self.state.brandName,
                    provider_bio: self.state.bio,
                    registration_number: ""
                )
            ) { response in
                response.handleState {
                    self.state.isLoading = true
                    print("Loading...")
                } onSuccess: { message in
                    self.state.isLoading = false
                    print(message)
                } onError: { error in
                    self.state.isLoading = false
                    self.state.showError = true
                    self.state.error = error
                    print(error)
                }
            }
        }
    }
    
    
}
