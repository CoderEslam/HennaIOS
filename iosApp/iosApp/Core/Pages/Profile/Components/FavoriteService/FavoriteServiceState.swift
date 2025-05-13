//
//  FavoriteServiceState.swift
//  iosApp
//
//  Created by Eslam Ghazy on 3/4/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import ComposeApp

struct FavoriteServiceState{
    var favoriteServiceList:FavoriteServiceList? = nil
    var showError:Bool = false
    var error:String = ""
    var isLoading:Bool = false
}
