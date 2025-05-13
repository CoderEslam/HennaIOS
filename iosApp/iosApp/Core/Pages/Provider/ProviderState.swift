//
//  PrividerState.swift
//  iosApp
//
//  Created by Eslam Ghazy on 4/4/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import ComposeApp

struct ProviderState {
    var providerList:ProviderList? = nil
    var prioviderModelList: [ProviderModel] = []
    var providerModelData:ProviderModelData? = nil
    var postsList:PostsList? = nil
    var postModel:PostModel? = nil
    var postModelList: [PostModel] = []
    var showPostContent : Bool = false
    var post_:Post_? = nil
    var addPost:Bool = false
    var userModel:UserModel? = nil
    var showContent:Bool = false
    var selectedTab:Int = -1
    var showProvider:Bool = false
    var providerId:Int = -1
    var search:String = ""
    var chat:Bool = false
    var game:Bool = false
    var setting:Bool = false
    var isLoading:Bool = false
    var showError:Bool = false
    var error:String = ""
}
