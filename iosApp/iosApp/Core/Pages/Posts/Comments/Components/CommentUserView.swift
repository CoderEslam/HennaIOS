//
//  CommentUserView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 28/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import ComposeApp

struct CommentUserView: View {
    @StateObject private var userDataViewModel = SettingsViewModel()
    @StateObject private var mainViewModel = ViewModel()
    var comment: Comment_
    var reload : () -> Void
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                LoadingImageView(imagePath: Constants().UsersImages + (comment.user?.user_image ?? ""))
                    .frame(width: 30,height: 30)
                    .cornerRadius(25)
                    .padding()
                Text("\(comment.user?.first_name ?? "") \(comment.user?.last_name ?? "")")
                    .padding()
                Spacer()
                if comment.user_id == KotlinInt(int: Int32(userDataViewModel.getUserId())) {
                    Menu {
                        Button("delete".localized, action: deleteComment)
                    } label: {
                        Label("", systemImage: "ellipsis")
                            .foregroundColor(.black)
                            .rotationEffect(.degrees(90))
                            .padding()
                            .bold()
                    }
                }
            }.frame(maxWidth: .infinity)
            
            Text("\(comment.content ?? "")")
                .padding(.all,8)
        }.frame(maxWidth: .infinity)
            .background{
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.theme.logoGreen.opacity(0.5))
            }.padding(.all,4)
    }
    
    func deleteComment() {
        mainViewModel.deleteCommentById(id: Int32(truncating: comment.id ?? -1)) { response in
            response.handleState {
                //Loading...
            } onSuccess: { message in
                print(message)
                reload()
            } onError: { error in
                print(error)
            }

        }
    }
}

#Preview {
    CommentUserView(comment: Comment_(content: "", id: 1, post_id: 1, user_id: 1, user: nil)){
        
    }
}
