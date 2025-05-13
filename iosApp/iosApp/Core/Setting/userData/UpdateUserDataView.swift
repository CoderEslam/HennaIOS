//
//  UpdateUserDataView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 27/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import ComposeApp

struct UpdateUserDataView : View {
    @StateObject private var userDataViewModel = SettingsViewModel()
    @StateObject private var updateUserViewModel = UpdateUserViewModel()
    @Binding var dismiss: Bool
    var body: some View {
        VStack{
            TopAppBarBackView {
                dismiss.toggle()
            }
            ScrollView (.vertical ,showsIndicators: false){
                VStack(alignment: .leading){
                    VStack(alignment: .leading){
                        Text("first_name".localized)
                            .bold()
                            .padding(8)
                        TextField("first_name".localized, text: $updateUserViewModel.state.firstName)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke()
                                    .fill(Color.theme.logoGreen)
                            )
                    }
                    
                    VStack(alignment: .leading){
                        Text("last_name".localized)
                            .bold()
                            .padding(8)
                        TextField("last_name".localized, text: $updateUserViewModel.state.lastName)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke()
                                    .fill(Color.theme.logoGreen)
                            )
                    }
                    if userDataViewModel.getProvider() != nil {
                        VStack(alignment: .leading){
                            Text("brand_name".localized)
                                .bold()
                                .padding(8)
                            TextField("brand_name".localized, text: $updateUserViewModel.state.brandName)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke()
                                        .fill(Color.theme.logoGreen)
                                )
                        }
                        
                        VStack(alignment: .leading){
                            Text("bio".localized)
                                .bold()
                                .padding(8)
                            TextField("bio".localized, text: $updateUserViewModel.state.bio)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke()
                                        .fill(Color.theme.logoGreen)
                                )
                        }
                    }
                    VStack(alignment: .leading){
                        Text("email".localized)
                            .bold()
                            .padding(8)
                        TextField("email".localized, text: $updateUserViewModel.state.email)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke()
                                    .fill(Color.theme.logoGreen)
                            )
                    }
                    VStack(alignment: .leading){
                        Text("phone".localized)
                            .bold()
                            .padding(8)
                        
                        HStack{
                            CountryCodeDialogView(selectedOldCode: $updateUserViewModel.state.countryCode) { country in
                                updateUserViewModel.onEvent(.selectedCountry(country))
                            }
                            Divider()
                            TextField("phone".localized, text: $updateUserViewModel.state.phone)
                                .padding()
                                .keyboardType(.numberPad)
                        }
                        .frame(height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke()
                                .fill(Color.theme.logoGreen)
                        )
                    }
                    VStack{
                        Text("select_country".localized)
                            .bold()
                            .padding(8)
                        SpinnerViewCompose(
                            items: updateUserViewModel.state.countriesList,
                            selectedItem: Binding(
                                get: { updateUserViewModel.state.selectedItemCountry ?? updateUserViewModel.state.countriesList.first },
                                set: { updateUserViewModel.onEvent(.selectedItemCountry($0)) }
                            ),
                            onItemSelected: { updateUserViewModel.onEvent(.selectedItemCountry($0)) }) {
                                $0?.name ?? ""
                            }
                        Text("select_province".localized)
                            .bold()
                            .padding(8)
                        SpinnerViewCompose(
                            items: updateUserViewModel.state.selectedItemCountry?.provinces ?? [],
                            selectedItem: Binding(
                                get: { updateUserViewModel.state.selectedItemProvince ?? updateUserViewModel.state.selectedItemCountry?.provinces?.first },
                                set: { updateUserViewModel.onEvent(.selectedItemProvince($0)) }
                            ),
                            onItemSelected: { updateUserViewModel.onEvent(.selectedItemProvince($0)) }) {
                                $0?.name ?? ""
                            }
                        Text("select_city".localized)
                            .bold()
                            .padding(8)
                        SpinnerViewCompose(
                            items: updateUserViewModel.state.selectedItemProvince?.cities ?? [],
                            selectedItem: Binding(
                                get: { updateUserViewModel.state.selectedItemCity ?? updateUserViewModel.state.selectedItemProvince?.cities?.first },
                                set: { updateUserViewModel.onEvent(.selectedItemCity($0)) }
                            ),
                            onItemSelected: { updateUserViewModel.onEvent(.selectedItemCity($0)) }) {
                                $0?.name ?? ""
                            }
                    }
                    VStack{
                        Text("select_language")
                            .bold()
                            .padding(8)
                        SpinnerViewCompose(
                            items: updateUserViewModel.state.languagesList,
                            selectedItem: Binding(
                                get: { updateUserViewModel.state.selectedItemLanguage ?? updateUserViewModel.state.languagesList.first }, // Default to the first item
                                set: { updateUserViewModel.onEvent(.selectedItemLanguage($0)) }
                            ),
                            onItemSelected: { updateUserViewModel.onEvent(.selectedItemLanguage($0)) }) {
                                $0?.name ?? ""
                            }
                    }
                }
            }
            
            
            HStack{
                Text("update".localized)
                    .frame(maxWidth: .infinity)
            }.frame(height: 50)
                .background{
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.theme.logoPink)
                }
                .padding()
                .onTapGesture {
                    updateUserViewModel.updateUser {
                        dismiss.toggle()
                    }
                }
        }
        .showLoader(loading: $updateUserViewModel.state.isLoading)
        .showErrorDialog(showError: $updateUserViewModel.state.showError , rawErrorMessage: updateUserViewModel.state.error ?? "")
        .padding(.horizontal)
    }
}

#Preview {
    UpdateUserDataView(dismiss: .constant(false))
}
