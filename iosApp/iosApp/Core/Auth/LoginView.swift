//
//  LoginView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 7/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import ComposeApp

struct LoginView: View {
    @StateObject private var authViewModel = AuthViewModel()
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            VStack(alignment: .center){
                login
            }
        }.frame(maxWidth: .infinity)
            .frame(maxHeight: .infinity)
    }
}

#Preview {
    LoginView()
}

extension LoginView {
    
    private var login : some View {
        VStack(alignment: .center){
            VStack(spacing: 20){
                TextField("email".localized, text: $authViewModel.state.email)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                            .fill(Color("logo_green"))
                    )
                SecureField("password".localized, text: $authViewModel.state.password)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                            .fill(Color("logo_green"))
                    )
                Text("forgot_your_password_reset_it_here".localized)
                    .font(.custom(Fonts.montserrat.rawValue, size: 12))
                    .frame(maxWidth: .infinity , alignment : .trailing)
                    .foregroundColor(Color("gray_text_color"))
                
                Text("login".localized)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color.white.opacity(0.8))
                    .padding(.vertical,20)
                    .background(
                        RoundedRectangle(cornerRadius: 50)
                            .fill(Color.theme.logoPink)
                    )
                    .padding(.top)
                    .onTapGesture {
                        authViewModel.onEvent(.login)
                    }
                Text("forgot_your_password_reset_it_here".localized)
                    .font(.custom(Fonts.montserrat.rawValue, size: 12))
                    .frame(maxWidth: .infinity , alignment : .center)
                    .foregroundColor(Color("gray_text_color"))
                    .padding(.top,20)
                
            }.padding()
        }
        .showLoader(loading: $authViewModel.state.isLoading)
        .showErrorDialog(showError: $authViewModel.state.showError, rawErrorMessage: authViewModel.state.error ?? "")
        .background{
            NavigationLink(destination: HomeView(), isActive: $authViewModel.state.home, label: {
                EmptyView()
            })
        }
        .frame(maxWidth: .infinity , maxHeight:.infinity)
        .ignoresSafeArea()
    }
}
