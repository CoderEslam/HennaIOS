//
//  SettingEvent.swift
//  iosApp
//
//  Created by Eslam Ghazy on 1/4/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import SwiftUI

enum SettingEvent {
    case openEditProfile(Bool)
    case openImagePicker(Bool)
    case selectedImage(UIImage?)
    case selectedImageData(Data?)
    case auth(Bool)
}
