//
//  ProfileProviderPageView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 30/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import ComposeApp

struct ProfileProviderPageView: View {
    @StateObject private var profileViewModel = ProfileViewModel()
    @StateObject private var userDataViewModel = SettingsViewModel()
    var actionHome:()-> Void
    private let tabs: [Tab] = [
        .init(icon: Image(systemName: ""), title: "information".localized),
        .init(icon: Image(systemName: ""), title: "services".localized),
        .init(icon: Image(systemName: ""), title: "posts".localized)
    ]
    
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            VStack {
                TopAppBarView(title: "profile".localized, chat: {
                    profileViewModel.state.chat.toggle()
                }, game: {
                    profileViewModel.state.game.toggle()
                }, home: {
                    actionHome()
                }, menu: {
                    profileViewModel.state.setting.toggle()
                }).padding(.vertical,32)
                ZStack{
                    if let image = profileViewModel.state.selectedBgImage {
                        Image(uiImage: image)
                            .resizable()
                        //.scaledToFit()
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                            .cornerRadius(10)
                            .padding()
                            .overlay{
                                HStack{
                                    if let userImage = profileViewModel.state.selectedUserImage {
                                        Image(uiImage: userImage)
                                            .resizable()
                                            .frame(width: 122,height: 122)
                                            .clipShape(Circle())
                                            .background{
                                                Circle()
                                                    .fill(.white)
                                            }.overlay{
                                                Image(systemName: "camera")
                                                    .frame(width: 36,height: 36)
                                                    .background{
                                                        Circle()
                                                            .fill(.white)
                                                    }
                                                    .frame(maxWidth: .infinity,maxHeight:.infinity,alignment:.bottomTrailing)
                                                    .onTapGesture {
                                                        profileViewModel.onEvent(.imageSelectable(.profile))
                                                        profileViewModel.state.showImagePicker.toggle()
                                                    }
                                            }
                                            .padding(.horizontal)
                                    } else {
                                        LoadingImageView(imagePath: Constants().UsersImages + (profileViewModel.state.userModel?.data?.user_image ?? ""))
                                            .frame(width: 122,height: 122)
                                            .clipShape(Circle())
                                            .background{
                                                Circle()
                                                    .fill(.white)
                                            }.overlay{
                                                Image(systemName: "camera")
                                                    .frame(width: 36,height: 36)
                                                    .background{
                                                        Circle()
                                                            .fill(.white)
                                                    }
                                                    .frame(maxWidth: .infinity,maxHeight:.infinity,alignment:.bottomTrailing)
                                                    .onTapGesture {
                                                        profileViewModel.onEvent(.imageSelectable(.profile))
                                                        profileViewModel.state.showImagePicker.toggle()
                                                    }
                                            }
                                            .padding(.horizontal)
                                    }
                                    
                                    Spacer()
                                    Image(systemName: "camera")
                                        .frame(width: 36,height: 36)
                                        .background{
                                            Circle()
                                                .fill(.white)
                                        }
                                        .padding(.horizontal)
                                        .onTapGesture {
                                            profileViewModel.onEvent(.imageSelectable(.bg))
                                            profileViewModel.state.showImagePicker.toggle()
                                        }
                                }.frame(maxHeight: .infinity,alignment: .bottom)
                                    .offset(x:0,y:60)
                        }
                    } else {
                        LoadingImageView(imagePath: Constants().BackgroundImages + (profileViewModel.state.userModel?.data?.background_image ?? ""))
                            .frame(height: 200)
                            .overlay{
                                HStack{
                                    if let userImage = profileViewModel.state.selectedUserImage {
                                        Image(uiImage: userImage)
                                            .resizable()
                                            .frame(width: 122,height: 122)
                                            .clipShape(Circle())
                                            .background{
                                                Circle()
                                                    .fill(.white)
                                            }.overlay{
                                                Image(systemName: "camera")
                                                    .frame(width: 36,height: 36)
                                                    .background{
                                                        Circle()
                                                            .fill(.white)
                                                    }
                                                    .frame(maxWidth: .infinity,maxHeight:.infinity,alignment:.bottomTrailing)
                                                    .onTapGesture {
                                                        profileViewModel.onEvent(.imageSelectable(.profile))
                                                        profileViewModel.state.showImagePicker.toggle()
                                                    }
                                            }
                                            .padding(.horizontal)
                                    } else {
                                        LoadingImageView(imagePath: Constants().UsersImages + (profileViewModel.state.userModel?.data?.user_image ?? ""))
                                            .frame(width: 122,height: 122)
                                            .clipShape(Circle())
                                            .background{
                                                Circle()
                                                    .fill(.white)
                                            }.overlay{
                                                Image(systemName: "camera")
                                                    .frame(width: 36,height: 36)
                                                    .background{
                                                        Circle()
                                                            .fill(.white)
                                                    }
                                                    .frame(maxWidth: .infinity,maxHeight:.infinity,alignment:.bottomTrailing)
                                                    .onTapGesture {
                                                        profileViewModel.onEvent(.imageSelectable(.profile))
                                                        profileViewModel.state.showImagePicker.toggle()
                                                    }
                                            }
                                            .padding(.horizontal)
                                    }
                                    Spacer()
                                    Image(systemName: "camera")
                                        .frame(width: 36,height: 36)
                                        .background{
                                            Circle()
                                                .fill(.white)
                                        }
                                        .padding(.horizontal)
                                        .onTapGesture {
                                            profileViewModel.onEvent(.imageSelectable(.bg))
                                            profileViewModel.state.showImagePicker.toggle()
                                        }
                                }.frame(maxHeight: .infinity,alignment: .bottom)
                                    .offset(x:0,y:60)
                            }
                    }
                }
                VStack {
                    HStack{
                        Text("\(profileViewModel.state.userModel?.data?.first_name ?? "") \(profileViewModel.state.userModel?.data?.last_name ?? "")")
                            .bold()
                            .foregroundColor(.black)
                            .font(.system(size: 24))
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    VStack{
                        Tabs(tabs: tabs, geoWidth: UIScreen.main.bounds.width, selectedTab: $profileViewModel.state.selectedTab)
                        // Views
                        TabView(selection: $profileViewModel.state.selectedTab, content: {
                            if let provider = profileViewModel.state.providerModelData?.data {
                                InformationPageView(data: provider).tag(0)
                                ProviderServicePageView(data: provider).tag(1)
                                ProviderPostsPageView(providerModel_: provider).tag(2)
                            }
                        })
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    }
                    .frame(height: 600)
                    .padding(.horizontal)
                    
                }.frame(maxWidth: .infinity)
                    .padding(.top,60)
            }
            .fullScreenCover(isPresented: $profileViewModel.state.game, content: {
                GamePagerView(){
                    profileViewModel.state.game.toggle()
                    actionHome()
                }
            }).fullScreenCover(isPresented: $profileViewModel.state.chat, content: {
                ChatListView(dismiss: $profileViewModel.state.chat)
            }).fullScreenCover(isPresented: $profileViewModel.state.setting, content: {
                SettingView(dismiss: $profileViewModel.state.setting)
            })
            .sheet(isPresented: $profileViewModel.state.showImagePicker) {
                ImagePicker(sourceType: .photoLibrary) { image in
                    if let image = image {
                        profileViewModel.state.showImagePicker.toggle()
                        if profileViewModel.state.imageSelectable == .profile {
                            profileViewModel.state.selectedUserImage = image
                            profileViewModel.uploadUserImage(image)
                        }
                        if profileViewModel.state.imageSelectable == .bg {
                            profileViewModel.state.selectedBgImage = image
                            profileViewModel.uploadUserBgImage(image)
                        }
                        
                    }
                }
            }.showLoader(loading: $profileViewModel.state.isLoading)
                .showErrorDialog(showError: $profileViewModel.state.showError, rawErrorMessage: $profileViewModel.state.error)
            .onAppear{
                if userDataViewModel.token != "" {
                    profileViewModel.showUser()
                    profileViewModel.showProvider()
                }
            }
        }
    }
}

#Preview {
    ProfileProviderPageView(){
        
    }
}
