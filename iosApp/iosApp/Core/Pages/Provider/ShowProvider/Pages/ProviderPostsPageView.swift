//
//  ProviderPostsPageView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 16/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import ComposeApp

struct ProviderPostsPageView: View {
    @StateObject private var providerViewModel = ProviderViewModel()
    @StateObject private var userDataViewModel = SettingsViewModel()
    var providerModel_: ProviderModel_
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                
                if userDataViewModel.getProvider() != nil {
                    HStack{
                        LoadingImageView(imagePath: Constants().UsersImages + (providerViewModel.state.userModel?.data?.user_image ?? ""))
                            .frame(width: 25,height: 25)
                            .clipShape(Circle())
                            .padding(8)
                        Text("what_do_you_think".localized)
                        Spacer()
                    }.background{
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1)
                            .fill(Color.theme.logoGreen)
                    }.padding(.vertical,4)
                        .onTapGesture {
                            providerViewModel.state.addPost.toggle()
                        }
                }
                ScrollView(.vertical,showsIndicators: false){
                    LazyVStack(content: {
                        ForEach(providerViewModel.state.postModelList, id: \.self.id) { post in
                            PostItemView(post: post) { post in
                                //like action
                                providerViewModel.setPostLike(Int32(truncating: post.id ?? 0))
                            } dislikeAction: { post in
                                //dislike
                                providerViewModel.dislikePost(Int32(truncating: post.id ?? 0))
                            } commentAction: { post in
                                //comment action
                                
                            } openContent: { post in
                                providerViewModel.state.postModel = post
                                providerViewModel.state.showPostContent.toggle()
                            } deletePostItem: { post in
                                providerViewModel.state.postModelList.removeAll(where: {$0.id == post.id})
                            }
                        }
                    })
                }
            }
//            switch postResponseState {
//            case .idle:
//                Text("").hidden()
//            case .loading:
//                ProgressView()
//            case .success(let data):
//                Text("").onAppear{
//                    if let index = postsList.firstIndex(where: { $0.id == providerModel_.data.id }) {
//                        postsList[index] = data.data
//                    }
//                }.hidden()
//            case .error(let error):
//                ErrorDialogView(errorMessage: "\(error)")
//            }
        }.fullScreenCover(isPresented: $providerViewModel.state.showContent, content: {
            ShowPostContentView(url: "")
        }).fullScreenCover(isPresented: $providerViewModel.state.showPostContent, content: {
            PostContentView(dismiss: $providerViewModel.state.showPostContent, postModel: $providerViewModel.state.postModel)
        }).fullScreenCover(isPresented: $providerViewModel.state.addPost, content: {
            AddPostView(dismiss: $providerViewModel.state.addPost)
        })
        .showLoader(loading: $providerViewModel.state.isLoading)
        .showErrorDialog(showError: $providerViewModel.state.showError, rawErrorMessage: $providerViewModel.state.error)
        .onAppear{
            providerViewModel.getPostsByProviderId(Int32(truncating: providerModel_.id ?? 0))
            providerViewModel.showUser()
        }
    }
}

#Preview {
    ProviderPostsPageView(providerModel_: ProviderModel_(brand_name: "", id: 1, provider_bio: "", services: nil, user: nil, user_id: 1))
}
