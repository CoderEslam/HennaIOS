//
//  ChatTextView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 20/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct ChatTextView: View {
    @StateObject private var userData = SettingsViewModel()
    var chat:Chat
    var body: some View {
        HStack{
            if userData.getUserId() == chat.to {
                Text("\(chat.text)")
                    .font(.system(size: 18))
                    .padding()
                    .foregroundColor(Color.black)
                    .background{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.theme.logoPink.opacity(0.5))
                    }
            }
            Spacer()
            if userData.getUserId() == chat.from {
                Text("\(chat.text)")
                    .font(.system(size: 18))
                    .padding()
                    .foregroundColor(Color.theme.greenDark)
                    .background{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.theme.greenDark.opacity(0.5))
                    }
            }
        }.padding(8)
    }
}

#Preview {
    ChatTextView(chat: Chat(from: 259, id: "-O9A8gtDq_C56lNKH3RS", text: "salam", to: 28, type: 0))
}
