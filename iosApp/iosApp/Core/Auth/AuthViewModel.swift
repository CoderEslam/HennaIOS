//
//  AuthViewModel.swift
//  iosApp
//
//  Created by Eslam Ghazy on 1/4/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import ComposeApp

class AuthViewModel: ObservableObject {
    
    private var mainViewModel = MainViewModel()
    @Published var state = LoginState()
    
    
    func onEvent(_ event: LoginEvent) {
        switch event {
        case .email(let email):
            state.email = email
        case .password(let password):
            state.password = password
        case .firstName(let firstName):
            state.firstName = firstName
        case .lastName(let lastName):
            state.lastName = lastName
        case .phone(let phone):
            state.phone = phone
        case .rememberMe(let rememberMe):
            state.rememberMe = rememberMe
        case .passwordVisible(let show):
            state.passwordVisible = show
        case .fcm(let fcm):
            state.fcm = fcm
        case .login:
            login()
        case .signUp:
            signUp()
        case .error(let error):
            state.error = error
        case .reset:
            state = LoginState()
        case .selectedCountry(let countryData):
            state.selectedCountry = countryData
        case .code(let code):
            state.code = code
        case .confirmPassword(let password):
            state.confirmPassword  = password
        case .checked(let checked):
            state.checked = checked
        }
        
    }
    
    private func login() {
        if (loginValidation()) {
            state.isLoading = true
            mainViewModel.login(loginModel: LoginModel(email: self.state.email, password: self.state.password)) { response in
                self.state.loginCallback = response
                self.state.isLoading = false
                self.state.loginSuccess = true
                self.state.showError = false
                self.state.home = true
            } error: { error in
                self.state.error = error
                self.state.isLoading = false
                self.state.showError = true
                self.state.loginSuccess = false
            }
        }
    }
    
    private func signUp() {
        if (signUpvalidation()) {
            state.isLoading = true
            mainViewModel.registerUser(
                registerModel:Register(
                    first_name: state.firstName,
                    last_name: state.lastName,
                    password: state.password,
                    password_confirmation: state.confirmPassword,
                    email: state.email,
                    phone: state.phone,
                    phone_extension: state.code)) { response in
                        self.state.loginCallback = response
                        self.state.isLoading = false
                        self.state.showError = false
                        self.state.loginSuccess = true
                        self.state.home = true
                    } error: { error in
                        self.state.error = error
                        self.state.showError = true
                        self.state.isLoading = false
                        self.state.loginSuccess = false
                    }
        }
    }
    
    
    private func loginValidation() -> Bool {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.state.error = ""
        }
        if self.state.email.isNotEmpty && self.state.password.isNotEmpty {
            return true
        } else {
            self.state.error = "insert_email_and_password_please".localized
            return false
        }
    }
    
    private func signUpvalidation() -> Bool {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.state.error = ""
        }
        if self.state.email.isNotEmpty && self.state.password.isNotEmpty && self.state.firstName.isNotEmpty && self.state.lastName.isNotEmpty && self.state.confirmPassword.isNotEmpty {
            return true
        } else {
            self.state.error = "insert_email_and_password_please".localized
            return false
        }
    }
    
    
}
