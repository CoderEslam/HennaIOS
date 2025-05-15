//
//  ChatView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 20/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct ChatView: View {
    @StateObject private var firebaseViewModel = FirebaseViewModel()
    @State private var chatResponseState: RequestState<[Chat]> = .idle
    @State private var message: String = ""
    @State private var keyboardHeight: CGFloat = 0 // Track keyboard height
    @Binding var dismiss : Bool
    @Binding var id: Int
    
    var body: some View {
        VStack {
            TopAppBarBackView {
                dismiss.toggle()
            }
            .padding(.top, 48)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    switch chatResponseState {
                    case .idle:
                        Text("")
                    case .loading:
                        ProgressView()
                    case .success(let data):
                        LazyVStack {
                            ForEach(data, id: \.self.id) { chat in
                                ChatTextView(chat: chat)
                            }
                        }
                    case .error(let error):
                        ErrorDialogView(errorMessage: "{\"message\":\"Unauthenticated.\"}")
                    }
                }.onAppear {
                    firebaseViewModel.readAllChats(providerId: Int(id) ?? -1) { response in
                        print("RESPONSE -> \(response)")
                        chatResponseState = response
                    }
                }
            }
            
            HStack {
                TextField("type_here".localized, text: $message)
                    .frame(height: 50)
                    .padding(.horizontal)
                    .background {
                        RoundedRectangle(cornerRadius: 50)
                            .fill(Color.theme.grayTextColor.opacity(0.5))
                    }
                    .padding(.horizontal)
                
                Image(systemName: "paperplane.fill")
                    .padding()
                    .onTapGesture {
                        if message != "" {
                            firebaseViewModel.sendMessage(message: message, providerId: Int(id) ?? -1) { response in
                                response.handleState {
                                    print("Loading...")
                                } onSuccess: { data in
                                    print(data)
                                } onError: { error in
                                    print(error)
                                }
                            }
                            message = ""
                        }
                    }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 80)
            .background {
                RoundedRectangle(cornerRadius: 1)
                    .fill(.white)
                    .shadow(color: .gray.opacity(0.3), radius: 4)
            }
            .padding(.bottom, keyboardHeight) // Adjust position with keyboard height
            .animation(.easeOut, value: keyboardHeight) // Animate the height change
        }
        //.showLoader(loading: .constant(true))
        //.showErrorDialog(showError: .constant(false), rawErrorMessage: "")
        .ignoresSafeArea(edges: .bottom)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            addKeyboardListeners()
        }
        .onDisappear {
            removeKeyboardListeners()
        }
    }
    
    // Add keyboard listeners
    private func addKeyboardListeners() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
            if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                self.keyboardHeight = keyboardFrame.height
            }
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
            self.keyboardHeight = 0
        }
    }
    
    // Remove keyboard listeners
    private func removeKeyboardListeners() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

#Preview {
    ChatView(dismiss: .constant(false), id: .constant(11) )
}
