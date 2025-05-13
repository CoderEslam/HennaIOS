//
//  CommentState.swift
//  iosApp
//
//  Created by Eslam Ghazy on 3/4/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import ComposeApp

struct CommentState {
    var comment:String = ""
    var userModel:UserModel? = nil
    var commentsList:CommentsList? = nil
    var isLoading:Bool = false
    var showError:Bool = false
    var error:String = ""
}
