//
//  ChatListView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 20/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct ChatListView: View {
    @StateObject private var firebaseViewModel = FirebaseViewModel()
    @State private var chatListResponseState : RequestState<[ChatList]> = .idle
    @Binding var dismiss : Bool
    @State private var showChat : Bool = false
    @State private var providerId : Int = 0
    var body: some View {
        NavigationView{
            VStack{
                TopAppBarBackView {
                    dismiss.toggle()
                }
                ScrollView{
                    switch chatListResponseState {
                    case .idle:
                        Text("")
                    case .loading:
                        ProgressView()
                    case .success(let data):
                        LazyVStack(content: {
                            ForEach(data, id: \.self.user_id) { chatList in
                                ChatItemView(chatList: chatList){ chat in
                                    print("CHATOD \(chat.user_id)")
                                    self.providerId = Int(chat.user_id) ?? 0
                                    showChat.toggle()
                                } update: {
                                    firebaseViewModel.readMyChatList { response in
                                        chatListResponseState = response
                                    }
                                }
                            }
                        })
                    case .error(let error):
                        ErrorDialogView(errorMessage: error)
                    }
                }
            }
        }
        //.showLoader(loading: .constant(true))
        //.showErrorDialog(showError: .constant(false), rawErrorMessage: "")
        .fullScreenCover(isPresented: $showChat, content: {
            ChatView(dismiss: $showChat, id: $providerId)
        }).onAppear{
            firebaseViewModel.readMyChatList { response in
                chatListResponseState = response
            }
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ChatListView(dismiss: .constant(false))
}

