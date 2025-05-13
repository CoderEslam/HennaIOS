//
//  HomeState.swift
//  iosApp
//
//  Created by Eslam Ghazy on 4/4/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import ComposeApp

struct HomeState {
    var providerResponseState:ProviderList? = nil
    var serviceResponseState:ServiceList? = nil
    var filterServiceResponseState:FilterList? = nil
    var categoryResponseState:CategoriesList? = nil
    var advResponseState:AdvertisementList? = nil
    var homeSearchResponseState:HomeCallback? = nil
    var serviceId:Int = -1
    var showService: Bool = false
    var showProvider:Bool = false
    var providerId:Int = -1
    var currentPage = 0
    var filterService : Bool = false
    var chat = false
    var game = false
    var setting = false
    var search: String = ""
    var isLoading:Bool = false
    var showError:Bool = false
    var error:String = ""
}
