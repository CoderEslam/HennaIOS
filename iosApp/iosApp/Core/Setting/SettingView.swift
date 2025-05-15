//
//  SettingView.swift
//  HennaApp
//
//  Created by Eslam Ghazy on 26/9/23.
//

import SwiftUI
import ComposeApp

struct SettingView: View {
    @StateObject private var settingViewModel = SettingViewModel()
    @Binding var dismiss: Bool
    @State private var open:Bool = false
    @State private var link :String = ""
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .leading){
                    TopAppBarBackView {
                        dismiss.toggle()
                    }
                    HStack{
                        if let userImage = settingViewModel.state.selectedImage {
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
                                            settingViewModel.onEvent(.openImagePicker(!settingViewModel.state.openImagePicker))
                                        }
                                }
                                .padding(.horizontal)
                        } else {
                            LoadingImageView(imagePath: Constants().UsersImages + (settingViewModel.state.userModel?.data?.user_image ?? ""))
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
                                            settingViewModel.onEvent(.openImagePicker(!settingViewModel.state.openImagePicker))
                                        }
                                }
                                .padding(.horizontal)
                        }
                        VStack(alignment: .leading,spacing: 12){
                            Text("\(settingViewModel.state.userModel?.data?.first_name ?? "") \(settingViewModel.state.userModel?.data?.last_name ?? "")")
                                .foregroundColor(.black)
                                .font(.system(size: 24))
                            Text("edit_profile".localized)
                                .foregroundColor(.gray)
                                .font(.system(size: 14))
                        }
                    }
                    
                    Divider()
                    
                    VStack(alignment: .leading){
                        Text("edit_profile".localized)
                            .foregroundColor(.gray)
                            .font(.system(size: 16))
                        HStack{
                            Image("profile_icon")
                            Text("personal_information".localized)
                                .foregroundColor(.black)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.black)
                        }.frame(height: 50)
                            .onTapGesture {
                                settingViewModel.onEvent(.openEditProfile(!settingViewModel.state.openEditProfile))
                            }
                        
                        Divider()
                        
                        HStack{
                            Image("provider_icon")
                            Text("join_to_us_as_provider".localized)
                                .foregroundColor(.black)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.black)
                        }.frame(height: 50)
                            .onTapGesture{
                                self.link = "https://hennapp.es/contact"
                                self.open.toggle()
                            }
                        
                        Divider()
                        
                        HStack{
                            Image(systemName: "arrowshape.right.circle")
                                .foregroundColor(Color.theme.logoGreen)
                            Text("terms_and_conditions".localized)
                                .underline()
                                .onTapGesture {
                                    self.link = "https://hennapp.es/terms"
                                    self.open.toggle()
                                }
                        }.frame(height: 50)
                        
                        Divider()
                        
                        HStack{
                            Image(systemName: "arrowshape.right.circle")
                                .foregroundColor(Color.theme.logoGreen)
                            Text("privacy".localized)
                                .underline()
                                .onTapGesture {
                                    self.link = "https://hennapp.es/privacy"
                                    self.open.toggle()
                                }
                        }.frame(height: 50)
                        
                        Divider()
                        HStack{
                            Image(systemName: "square.and.arrow.up")
                                .rotationEffect(Angle(degrees: 90))
                                .foregroundColor(Color.theme.logoGreen)
                            
                            Text("logout".localized).foregroundColor(.black)
                            
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.black)
                        }
                        .onTapGesture {
                            settingViewModel.logout()
                        }
                        
                        Divider()
                        Spacer()
                        
                        HStack{
                            Text("delete_account".localized)
                                .foregroundColor(Color.red)
                                .underline()
                                .onTapGesture {
                                    self.link = "https://hennapp.es/delete-account"
                                    self.open.toggle()
                                }
                        }.frame(height: 50)
                        
                    }.padding(.top)
                    
                }
                .padding(.horizontal)
            }.fullScreenCover(isPresented: $settingViewModel.state.openEditProfile, content: {
                UpdateUserDataView(dismiss: $settingViewModel.state.openEditProfile)
            }).sheet(isPresented: $settingViewModel.state.openImagePicker) {
                ImagePicker(sourceType: .photoLibrary) { image in
                    if let image = image {
                        settingViewModel.onEvent(.selectedImage(image))
                        settingViewModel.onEvent(.selectedImageData(image.jpegData(compressionQuality: 0.1)))
                        settingViewModel.onEvent(.openImagePicker(!settingViewModel.state.openImagePicker))
                        settingViewModel.uploadImage(image)
                    }
                }
            }.fullScreenCover(isPresented: $open, content: {
                SafariView(url: URL(string: "\(link)")!)
            })
            .background{
                NavigationLink(destination: AuthView(), isActive: $settingViewModel.state.goToAuth, label: {
                    EmptyView()
                })
            }
            .onAppear{
                settingViewModel.loadUserData()
            }
        }
//        .showLoader(loading: $settingViewModel.state.isLoading)
        .showErrorDialog(showError: $settingViewModel.state.showError, rawErrorMessage: $settingViewModel.state.error)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    SettingView(dismiss: .constant(false))
}
