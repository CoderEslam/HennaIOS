//
//  ShowProviderView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 15/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import ComposeApp

struct ShowProviderView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var dismiss : Bool
    @Binding var providerId : Int
    @StateObject private var mainViewModel = ViewModel()
    @StateObject private var userData = SettingsViewModel()
    @StateObject private var firebaseViewModel = FirebaseViewModel()
    @State private var providerDataResponseState : RequestState<ProviderModelData> = .idle
    @State private var chat = false
    @State private var userProviderId = 0
    private let tabs: [Tab] = [
        .init(icon: Image(systemName: ""), title: "information".localized),
        .init(icon: Image(systemName: ""), title: "services".localized),
        .init(icon: Image(systemName: ""), title: "posts".localized)
    ]
    @State private var selectedTab: Int = 0
    var body: some View {
        VStack(alignment: .leading){
            TopAppBarBackView {
                presentationMode.wrappedValue.dismiss()
            }
            VStack{
                switch providerDataResponseState {
                case .idle:
                    Text("").hidden()
                case .loading:
                    ProgressView()
                case .success(let data):
                    ScrollView(.vertical ,showsIndicators: false){
                        VStack(alignment: .leading){
                            HStack{
                                LoadingImageView(imagePath: Constants().BackgroundImages + (data.data?.user?.background_image ?? ""))
                                    .frame(width: 350,height: 350)
                                    .overlay{
                                        VStack{
                                            Spacer()
                                            HStack{
                                                LoadingImageView(imagePath: Constants().UsersImages + (data.data?.user?.user_image ?? ""))
                                                    .frame(width: 100,height: 100)
                                                    .cornerRadius(50)
                                                    .background{
                                                        RoundedRectangle(cornerRadius: 50)
                                                            .fill(Color.white)
                                                            .shadow(color: .black.opacity(0.2), radius: 10)
                                                    }.offset(x: 10,y:50)
                                                Spacer()
                                            }
                                        }
                                    }.background{
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(Color.white)
                                            .shadow(color: .black.opacity(0.2), radius: 10)
                                    }.padding(1)
                            }.frame(maxWidth: .infinity)
                            
                            VStack(alignment: .leading){
                                Text("\(data.data?.user?.first_name ?? "") \(data.data?.user?.last_name ?? "")")
                                
                                HStack{
                                    Menu {
                                        Button("block".localized, action: blockProvider)
                                    } label: {
                                        Label("", systemImage: "ellipsis")
                                            .rotationEffect(Angle(degrees: 90))
                                            .foregroundColor(.red)
                                            .padding()
                                            .bold()
                                    }
                                    Spacer()
                                    Image("chat")
                                        .resizable()
                                        .frame(width: 60,height: 60)
                                        .onTapGesture {
                                            self.userProviderId = Int(data.data?.user_id ?? 0)
                                            firebaseViewModel.createChatList(
                                                providerId: Int(data.data?.user_id ?? 0),
                                                providerImage: data.data?.user?.user_image ?? "",
                                                providerName: "\(data.data?.user?.first_name ?? "") \(data.data?.user?.last_name ?? "")") { response in
                                                    response.handleState {
                                                        print("Loading...")
                                                    } onSuccess: { data in
                                                        print(data)
                                                        chat = true
                                                    } onError: { error in
                                                        print(error)
                                                    }
                                                }
                                        }
                                }
                                
                                VStack{
                                    GeometryReader { geo in
                                        VStack(alignment: .leading, spacing: 0) {
                                            // Tabs
                                            Tabs(tabs: tabs, geoWidth: geo.size.width, selectedTab: $selectedTab)
                                            
                                            // Views
                                            TabView(selection: $selectedTab, content: {
                                                if let provider = data.data {
                                                    InformationPageView(data: provider).tag(0)
                                                    ProviderServicePageView(data: provider).tag(1)
                                                    ProviderPostsPageView(providerModel_: provider).tag(2)
                                                }
                                            })
                                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                                        }
                                        .navigationBarTitleDisplayMode(.inline)
                                        .ignoresSafeArea()
                                    }
                                }.frame(height: 500)
                                    .padding(.top)
                                
                            }.padding(.top,50)
                            
                        }
                    }.padding()
                case .error(let error):
                    ErrorDialogView(errorMessage: "\(error)")
                }
            }
            .frame(maxWidth: .infinity)
            Spacer()
        }.fullScreenCover(isPresented: $chat, content: {
            ChatView(dismiss: $chat, id: $userProviderId)
        })
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear{
            mainViewModel.showProviderById(id: providerId) { response in
                providerDataResponseState = response
            }
        }
    }
    func blockProvider(){
        userData.setProvidersBlockIds(id: providerId)
    }
}

#Preview {
    ShowProviderView(dismiss : .constant(true),providerId: .constant(-1))
}
