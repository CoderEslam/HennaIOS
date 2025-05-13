//
//  SettingState.swift
//  iosApp
//
//  Created by Eslam Ghazy on 1/4/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import SwiftUI
import ComposeApp

struct SettingState {
    var userModel : UserModel? = nil
    var openEditProfile:Bool = false
    var openImagePicker: Bool = false
    var selectedImage: UIImage? = nil
    var selectedImageData: Data? = nil
    var goToAuth:Bool = false
    var isLoading = false
    var showError = false
    var error: String? = nil
}
