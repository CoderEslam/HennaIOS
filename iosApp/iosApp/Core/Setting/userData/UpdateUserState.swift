//
//  UpdateUserState.swift
//  iosApp
//
//  Created by Eslam Ghazy on 1/4/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import ComposeApp

struct UpdateUserState {
    var firstName:String = ""
    var lastName:String = ""
    var brandName:String = ""
    var bio:String = ""
    var email:String = ""
    var phone:String = ""
    var countryCode:String = ""
    var selectedCountry : CountryData? = nil
    var countriesList:[CountryModel] = []
    var selectedItemCountry: CountryModel? = nil
    var selectedItemProvince:ProvincesModel? = nil
    var selectedItemCity:CityModel? = nil
    var languagesList:[LanguagesModel] = []
    var selectedItemLanguage: LanguagesModel? = nil
    var userModel:UserModel? = nil
    var interests:[InterestsModel] = []
    var isLoading:Bool = false
    var showError = false
    var error:String = ""
}

