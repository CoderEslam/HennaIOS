//
//  FilterState.swift
//  iosApp
//
//  Created by Eslam Ghazy on 4/4/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import SwiftUI
import ComposeApp

struct FilterState {
    var categoryList:CategoriesList? = nil
    var countryList:CountriesList? = nil
    var provinceList:ProvincesList? = nil
    var cityList:CityList? = nil
    var currencyList:CurrenciesList? = nil
    var filterList:FilterList? = nil
    var selectedItemCategory:CategoryModel? = nil
    var selectedItemCountry:CountryModel? = nil
    var selectedItemProvince:ProvincesModel? = nil
    var selectedItemCity:CityModel? = nil
    var selectedItemCurrency:CurrencyModel? = nil
    var showFilterResult : Bool = false
    var isLoading:Bool = false
    var showError:Bool = false
    var error:String = ""
}
