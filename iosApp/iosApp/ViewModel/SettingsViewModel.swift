//
//  SettingsViewModel.swift
//  iosApp
//
//  Created by Eslam Ghazy on 8/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation
import ComposeApp

class SettingsViewModel : ObservableObject {
    
    private let userDateViewModel: UserDataViewModel =  UserDataViewModel()
    @Published var token : String = ""
    
    init() {
        getToken()
    }
    
    func getToken() {
        userDateViewModel.getTokenFlow { token in
            if (token != nil && token.isNotEmpty){
                self.token = token
            }
        }
    }
    
    
    func getUserId() -> Int32 {
        return userDateViewModel.getUserId()
    }
    
    func getUser() -> User {
        return userDateViewModel.getUserNormal()
    }
    
    func getAppLang() -> String {
        return "en"
//        if (userDateViewModel.getAppLang().isNotEmpty){
//            return userDateViewModel.getAppLang()
//        } else {
//            return ""
//        }
    }
    
    func getProviderId() -> Int {
        Int(truncating: 25)
    }
    
    func getProvider() -> Provider? {
        return userDateViewModel.getProviderNormal()
    }
    
    func loginAsGuest() {
        userDateViewModel.loginAsGuest()
    }
    
    func setProvidersBlockIds(id: Int) {
        userDateViewModel.setProvidersBlockIds(id: Int32(id))
    }
    
    func logout(){
        userDateViewModel.logout()
    }
    
}
