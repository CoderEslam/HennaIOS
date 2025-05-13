//
//  ChatItemView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 20/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct ChatItemView: View {
    @StateObject private var firebaseViewModel = FirebaseViewModel()
    var chatList : ChatList
    var action:(_ chatList : ChatList) -> Void
    var update:() -> Void
    var body: some View {
        HStack{
            HStack{
                LoadingImageView(imagePath: chatList.image)
                    .frame(width: 50,height: 50)
                    .cornerRadius(50)
                Text("\(chatList.name)")
                Spacer()
                Text("\("\(chatList.time)".toTime("yyyy-MM-dd HH:mm:ss").toString("yyyy-MM-dd HH:mm:ss"))")
                    .lineLimit(1)
            }.onTapGesture {
                action(chatList)
            }
            Menu {
                Button("delete".localized, action: deleteChat)
            } label: {
                Label("", systemImage: "ellipsis")
                    .foregroundColor(.black)
                    .rotationEffect(.degrees(90))
                    .padding()
                    .bold()
            }
        }.padding(8)
            
    }
    
    func deleteChat() {
        // delete here
        firebaseViewModel.deleteChatProvider(providerId: Int(chatList.user_id) ?? -1) { response in
            response.handleState {
                print("Loading...")
            } onSuccess: { data in
                print(data)
                update()
            } onError: { error in
                print(error)
            }
        }
    }
}

#Preview {
    ChatItemView(chatList: ChatList(
        image: "https://backend.hennapp.es/public/user_images/image_1712207542_users.png",
        name: "Mouna Lkhayat",
        user_id: "11",
        time: 1728964323402)){ chat in
        
        } update: {
            
        }
}
