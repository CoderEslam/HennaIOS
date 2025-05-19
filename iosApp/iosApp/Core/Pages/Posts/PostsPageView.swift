//
//  PostsPageView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 7/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import ComposeApp

struct PostsPageView: View {
    @StateObject private var mainViewModel = ViewModel()
    @StateObject private var settingsViewModel : SettingsViewModel = SettingsViewModel()
    @State private var postsResponseState : RequestState<PostsList> = .idle
    @State private var postResponseState : RequestState<Post_> = .idle
    @State private var showContent : Bool = false
    @State private  var postsList: [PostModel] = []
    @State private var chat = false
    @State private var game = false
    @State private var setting = false
    @State private var showCommentsPage : Bool = false
    @State private var showPostContent : Bool = false
    @State private var postModel : PostModel? = nil
    @State private var postId : Int = -1
    var actionHome:()-> Void
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            VStack{
                TopAppBarView(title: "posts".localized) {
                    //chat
                    chat.toggle()
                } game: {
                    //game
                    game.toggle()
                } home: {
                    //home
                    actionHome()
                } menu: {
                    //menu
                    setting.toggle()
                }.padding(.vertical,32)
            }
            switch postsResponseState {
            case .idle:
                Text("").hidden()
            case .loading:
                ProgressView()
            case .success(let data):
                VStack{
                    LazyVStack(content: {
                        ForEach(postsList, id: \.self.id) { post in
                            PostItemView(post: post) { post in
                                //like action
                                mainViewModel.setPostLike(postId: Int32(truncating: post.id ?? 0)) { response in
                                    postResponseState = response
                                    setLike(response: response)
                                    print(response)
                                }
                            } dislikeAction: { post in
                                //dislike
                                mainViewModel.deletePostLike(postId: Int32(truncating: post.id ?? 0)) { response in
                                    postResponseState = response
                                    setLike(response: response)
                                    print(response)
                                }
                            } commentAction: { post in
                                //comment action
                                postId = Int(truncating: post.id ?? 0)
                                showCommentsPage.toggle()
                            } openContent: { post in
                                self.postModel = post
                                showPostContent.toggle()
                            } deletePostItem: { post in
                                postsList.removeAll(where: {$0.id == post.id})
                            }
                        }
                    })
                    .onAppear{
                        self.postsList = data.data ?? []
                    }
                }
            case .error(let error):
                Text("\(error)")
            }
        }.onAppear{
            if settingsViewModel.token != "" {
                mainViewModel.posts { response in
                    postsResponseState = response
                }
            }
        }.fullScreenCover(isPresented: $showContent, content: {
            ShowPostContentView(url: "")
        }).fullScreenCover(isPresented: $game, content: {
            GamePagerView(){
                game.toggle()
                actionHome()
            }
        }).fullScreenCover(isPresented: $chat, content: {
            ChatListView(dismiss: $chat)
        }).fullScreenCover(isPresented: $setting, content: {
            SettingView(dismiss: $setting)
        }).fullScreenCover(isPresented: $showCommentsPage, content: {
            CommentsView(dismiss: $showCommentsPage,postId: $postId)
        }).fullScreenCover(isPresented: $showPostContent, content: {
            PostContentView(dismiss: $showPostContent, postModel: $postModel)
        })
    }
    
    private func setLike(response:RequestState<Post_>){
        response.handleState {
            print("Loading...")
        } onSuccess: { post in
            if let index = postsList.firstIndex(where: { $0.id == post.data.id }) {
                postsList[index] = post.data
            }
        } onError: { error in
            print("\(error)")
        }

    }
}

#Preview {
    PostsPageView(){
        
    }
}
