//
//  CommentsView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 28/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import ComposeApp

struct CommentsView: View {
    @StateObject private var commentViewModel = CommentViewModel()
    @Binding var dismiss : Bool
    @Binding var postId : Int
    var body: some View {
        VStack{
            TopAppBarBackView {
                dismiss.toggle()
            }
            ScrollView(.vertical,showsIndicators: false){
                LazyVStack(content: {
                    ForEach(commentViewModel.state.commentsList?.data.comments ?? [], id: \.self.id) { comment in
                        CommentUserView(comment: comment){
                            commentViewModel.getCommentPostById(Int32(postId))
                        }
                    }
                })
            }
            
            HStack{
                LoadingImageView(imagePath: Constants().UsersImages + (commentViewModel.state.userModel?.data?.user_image ?? ""))
                    .frame(width: 50,height: 50)
                    .cornerRadius(25)
                    .padding(.all,4)
                TextField("comment".localized, text: $commentViewModel.state.comment)
                    .padding(.horizontal,4)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background{
                        RoundedRectangle(cornerRadius: 25)
                            .fill(.white)
                    }.padding(.horizontal,4)
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.black)
                    .frame(width: 30,height: 30)
                    .padding(.all,4)
                    .onTapGesture {
                        commentViewModel.onEvent(.setComment(Int32(postId)))
                    }
                
            }.frame(maxWidth: .infinity)
                .frame(height: 60)
                .background{
                    Color.gray.opacity(0.5)
                }
        }.showLoader(loading: $commentViewModel.state.isLoading)
            .showErrorDialog(showError: $commentViewModel.state.showError, rawErrorMessage: commentViewModel.state.error)
            .onAppear{
                commentViewModel.getCommentPostById(Int32(postId))
                commentViewModel.showUser()
            }
    }
}

#Preview {
    CommentsView(dismiss: .constant(false), postId: .constant(-1))
}
