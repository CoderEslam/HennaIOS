//
//  LoginEvent.swift
//  iosApp
//
//  Created by Eslam Ghazy on 1/4/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation

enum LoginEvent {
    case email(String)
    case password(String)
    case confirmPassword(String)
    case firstName(String)
    case lastName(String)
    case phone(String)
    case selectedCountry(CountryData?)
    case code(String)
    case rememberMe(Bool)
    case passwordVisible(Bool)
    case fcm(String)
    case checked(Bool)
    case login
    case signUp
    case error(String)
    case reset
}
