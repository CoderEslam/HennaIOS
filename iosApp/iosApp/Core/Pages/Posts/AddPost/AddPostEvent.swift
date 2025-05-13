//
//  AddPostEvent.swift
//  iosApp
//
//  Created by Eslam Ghazy on 3/4/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation

enum AddPostEvent {
    case type(ContentType)
    case data(Data?)
}
