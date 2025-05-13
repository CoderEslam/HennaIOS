//
//  AddPostState.swift
//  iosApp
//
//  Created by Eslam Ghazy on 3/4/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import ComposeApp

struct AddPostState {
    var userModel : UserModel? = nil
    var description: String = ""
    var type: String = ""
    var content: Data? = nil
    var isLoading:Bool = false
    var showError:Bool = false
    var error:String = ""
}
