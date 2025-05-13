//
//  ProfileState.swift
//  iosApp
//
//  Created by Eslam Ghazy on 3/4/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import SwiftUI
import ComposeApp

struct ProfileState {
    var selectedTab: Int = 0
    var chat = false
    var game = false
    var setting = false
    var showImagePicker = false
    var selectedBgImage: UIImage? = nil
    var selectedUserImage : UIImage? = nil
    var imageSelectable : UserImage = .nothing
    var isLoading:Bool = false
    var error:String = ""
    var showError: Bool = false
    var userModel:UserModel? = nil
    var providerModelData:ProviderModelData? = nil
}
