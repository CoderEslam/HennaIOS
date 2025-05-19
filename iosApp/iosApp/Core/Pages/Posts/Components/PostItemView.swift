//
//  PostItemView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 16/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import ComposeApp

struct PostItemView: View {
    @StateObject private var userData = SettingsViewModel()
    @StateObject private var mainViewModel = ViewModel()
    @State private var likeState:Bool = false
    @State private var totalLike : Int = 0
    var post: PostModel
    var likeAction:(_ post: PostModel)->Void
    var dislikeAction:(_ post: PostModel)->Void
    var commentAction:(_ post: PostModel)->Void
    var openContent : (_ post: PostModel)->Void
    var deletePostItem :  (_ post: PostModel)->Void
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                LoadingImageView(imagePath: Constants().UsersImages + (post.user?.user_image ?? ""))
                    .frame(width: 40,height: 40)
                    .cornerRadius(20)
                    .clipShape(Circle())
                Text("\(post.user?.first_name ?? "") \(post.user?.last_name ?? "")")
                Spacer()
                if userData.token != "" {
                    if userData.getUserId() == Int(truncating: post.user_id ?? -1) {
                        Menu {
                            Button("delete".localized, action: deletePost)
                        } label: {
                            Label("", systemImage: "trash")
                                .foregroundColor(.red)
                                .padding()
                                .bold()
                        }
                    }
                }
                Menu {
                    Button("report".localized, action: reportPost)
                } label: {
                    Label("", systemImage: "exclamationmark.bubble")
                        .foregroundColor(.red)
                        .padding()
                        .bold()
                }
            }
            ViewMoreTextView(
                text: "\(post.description_ ?? "")",
                visibleLines: 50,
                ellipsizedTextColor: .blue,
                isUnderlined: true
            )
            
            LoadingImageView(imagePath: Constants().PostContent + (post.content ?? ""))
                .frame(width: 350,height: 400)
                .cornerRadius(15)
                .onTapGesture {
                    openContent(post)
                }
            HStack(spacing: 16){
                Image(systemName: likeState ? "heart.fill" : "heart")
                    .resizable()
                    .foregroundColor(likeState ? .red : .black)
                    .frame(width: 30,height: 30)
                    .onTapGesture {
                        if likeState {
                            totalLike -= 1
                            dislikeAction(post)
                        } else {
                            totalLike += 1
                            likeAction(post)
                        }
                        likeState.toggle()
                    }
                
                Text("\(totalLike)")
                
                Image("comment")
                    .resizable()
                    .frame(width: 30,height: 30)
                    .onTapGesture {
                        commentAction(post)
                    }
                Text("\(post.comments_count ?? 0)")
                Spacer()
            }
        }
        .padding()
            .background{
                RoundedRectangle(cornerRadius: 15)
                    .fill(.white)
                    .shadow(color: .gray.opacity(0.5), radius: 1)
            }.padding(5)
            .onAppear {
                self.totalLike = Int(truncating: post.likes_count ?? 0)
                if post.likes?.contains(where: { like in
                    Int32(truncating: like.user_id ?? 0) == userData.getUserId()
                }) == true {
                    likeState = true
                }
            }
    }
    
    func deletePost() {
        // delete here
        mainViewModel.deletePost(id: Int32(truncating: post.id ?? -1)) { response in
            response.handleState {
                print("Loading...")
            } onSuccess: { response in
                deletePostItem(post)
            } onError: { error in
                print("\(error)")
            }
            
        }
    }
    
    func reportPost() {
        // report here
        mainViewModel.sendReport(sendReport: SendReport(
            email: "\(String(describing: userData.getUser().email))",
            contentType: "post",
            contentId: "\(String(describing: post.id))")) { response in
            response.handleState {
                print("Loading...")
            } onSuccess: { response in
                print("Done")
            } onError: { error in
                print("\(error)")
            }
        }
    }
}

#Preview {
    PostItemView(post: PostModel(comments: [Comment_(content: "", id: 1, post_id: 1, user_id: 1, user: nil)], comments_count: 1, content: "", description: "This is a long text example to demonstrate the ViewMoreTextView implementation in SwiftUI. It supports toggling between expanded and collapsed states.", favorites: [Favorite(id: 1, post_id: 1, user_id: 1)], favorites_count: 1, id: 1, likes: [Like(id: 1, post_id: 1, user_id: 1)], likes_count: 2, type: "", user: nil, user_id: 1), likeAction: { post in
        
    }, dislikeAction: {post in
        
    }, commentAction: { post in
        
    }) { post in
        
    } deletePostItem: { post in
        
    }
}
