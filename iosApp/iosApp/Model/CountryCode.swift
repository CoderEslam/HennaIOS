//
//  CountryCode.swift
//  iosApp
//
//  Created by Eslam Ghazy on 16/2/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation

struct CountryCode : Codable {
    let countryCode : [CountryData]
}

struct CountryData : Codable ,Hashable {
    let name : String
    let flag : String
    let code : String
    let dial_code : String
}
