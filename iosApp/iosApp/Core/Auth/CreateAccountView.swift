//
//  CreateAccountView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 7/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import ComposeApp

struct CreateAccountView: View {
    @StateObject private var authViewModel = AuthViewModel()
    @FocusState private var hideKeyboard : Bool
    var body: some View {
        VStack(alignment: .center){
            ScrollView(.vertical ,showsIndicators: false){
                goToHome
                signup
            }
        }
        
    }
}

#Preview {
    CreateAccountView()
}

extension CreateAccountView {
    private var signup : some View {
        VStack(alignment: .center){
            VStack(spacing: 20){
                TextField("first_name".localized, text: $authViewModel.state.firstName)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                            .fill(Color.theme.logoGreen)
                    )
                TextField("last_name".localized, text: $authViewModel.state.lastName)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                            .fill(Color.theme.logoGreen)
                    )
                
                TextField("email".localized, text: $authViewModel.state.email)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                            .fill(Color.theme.logoGreen)
                    )
                
//                HStack{
//                    CountryCodeDialogView(selectedOldCode: .constant("")) { country in
//                        authViewModel.onEvent(.selectedCountry(country))
//                    }
//                    Divider()
//                    TextField("0123456789", text: $authViewModel.state.phone)
//                        .frame(maxWidth: .infinity)
//                        .keyboardType(.numberPad)
//                        .onChange(of : authViewModel.state.phone) { value in
//                            authViewModel.onEvent(.code(value))
//                        }.toolbar{
//                            ToolbarItemGroup(placement: .keyboard){
//                                Spacer()
//                                Button("Done"){
//                                    hideKeyboard = false
//                                }
//                            }
//                        }.focused($hideKeyboard)
//                }
//                .frame(height: 50)
//                .background(
//                    RoundedRectangle(cornerRadius: 10)
//                        .stroke()
//                        .fill(Color.theme.logoGreen)
//                )
                
                SecureField("Password", text: $authViewModel.state.password)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                            .fill(Color.theme.logoGreen)
                    )
                
                SecureField("confirm_password".localized, text: $authViewModel.state.confirmPassword)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                            .fill(Color.theme.logoGreen)
                    )
                HStack{
                    CheckBoxView(checked: $authViewModel.state.checked, text: .constant("i_agree_to_the_terms_and_conditions".localized))
                        .underline()
                        .onTapGesture {
                            withAnimation{
                                authViewModel.onEvent(.checked(!authViewModel.state.checked))
                            }
                        }
                    Spacer()
                    
                }
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
                        authViewModel.onEvent(.signUp)
                    }
                Text("forgot_your_password_reset_it_here".localized)
                    .font(.custom(Fonts.montserrat.rawValue, size: 12))
                    .frame(maxWidth: .infinity , alignment : .center)
                    .foregroundColor(Color.theme.grayTextColor)
                    .padding(.top,20)
            }.padding()
        }
        .frame(maxWidth: .infinity , maxHeight:.infinity)
        .showLoader(loading: $authViewModel.state.isLoading)
        .showErrorDialog(showError: $authViewModel.state.showError, rawErrorMessage: $authViewModel.state.error)
        .ignoresSafeArea()
    }
    
    private var goToHome : some View {
        NavigationLink(destination: HomeView(), isActive: $authViewModel.state.home, label: {
            EmptyView()
        })
    }
}

