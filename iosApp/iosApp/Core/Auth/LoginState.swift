//
//  LoginState.swift
//  iosApp
//
//  Created by Eslam Ghazy on 1/4/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import ComposeApp

struct LoginState {
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var phone: String = "123456789"
    var fcm: String = ""
    var selectedCountry: CountryData? = nil
    var code : String = "+212"
    var checked : Bool = false
    var rememberMe: Bool = false
    var passwordVisible: Bool = false
    var isLoading: Bool = false
    var loginSuccess: Bool = false
    var error: String = ""
    var showError:Bool = false
    var loginCallback: LoginCallback? = nil
    var home:Bool = false
}
