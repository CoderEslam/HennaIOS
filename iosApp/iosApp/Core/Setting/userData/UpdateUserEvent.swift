//
//  UpdateUserEvent.swift
//  iosApp
//
//  Created by Eslam Ghazy on 1/4/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import ComposeApp

enum UpdateUserEvent {
    case firstName(String)
    case lastName(String)
    case brandName(String)
    case bio(String)
    case email(String)
    case phone(String)
    case countryCode(String)
    case selectedCountry(CountryData?)
    case selectedItemCountry(CountryModel?)
    case selectedItemProvince(ProvincesModel?)
    case selectedItemCity(CityModel?)
    case selectedItemLanguage(LanguagesModel?)
}
