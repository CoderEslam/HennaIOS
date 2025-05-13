//
//  PostContentView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 28/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import ComposeApp

struct PostContentView: View {
    @Binding var dismiss : Bool
    @Binding var postModel: PostModel?
    var body: some View {
        VStack{
            TopAppBarBackView {
                dismiss.toggle()
            }
            if let post = postModel {
                LoadPostContentView(postModel: post)
            }
        }.frame(maxWidth: .infinity)
            .frame(maxHeight: .infinity)
    }
}

#Preview {
    PostContentView(dismiss : .constant(false), postModel: .constant(PostModel(comments: nil, comments_count: 1, content: "", description: "", favorites: nil, favorites_count: 1, id: 1, likes: nil, likes_count: 1, type: "", user: nil, user_id: 1)))
}
