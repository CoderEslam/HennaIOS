//
//  ProviderPageView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 7/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import ComposeApp

struct ProviderPageView : View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var mainViewModel = ViewModel()
    @State private var providerResponseState : RequestState<ProviderList> = .idle
    private let gridItems:[GridItem] = [
        .init(.flexible(),spacing: 1),
        .init(.flexible(),spacing: 1)
    ]
    @State private var prioviderModelList: [ProviderModel] = []
    @State private var showProvider:Bool = false
    @State private var providerId:Int = -1
    @State var search: String = ""
    @State private var chat = false
    @State private var game = false
    @State private var setting = false
    var actionHome:()-> Void
    var body: some View {
        ScrollView{
            VStack{
                TopAppBarView(title: "providers".localized) {
                    //chat
                    chat.toggle()
                } game: {
                    //game
                    game.toggle()
                } home: {
                    //home
                    actionHome()
                } menu: {
                    //menu
                    setting.toggle()
                }.padding(.vertical,32)
                VStack{
                    HStack{
                        Image("search")
                        TextField("search".localized, text: $search)
                        Image("filter_icon")
                    }.padding(.horizontal)
                        .frame(height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke().fill(Color.theme.logoGreen)
                        ).onChange(of: search, perform: { newValue in
                            mainViewModel.getProvidersSearch(search_input: newValue) { response in
                                response.handleState {
                                    print("Loading...")
                                } onSuccess: { data in
                                    prioviderModelList = data.data
                                } onError: { error in
                                    print("\(error)")
                                }
                            }
                        })                    
                    //post gridview
                    switch providerResponseState {
                    case .idle:
                        Text("")
                    case .loading:
                        ProgressView()
                    case .success(let data):
                        LazyVGrid(columns: gridItems,spacing: 1){
                            ForEach(prioviderModelList,id: \.self.id){ provider  in
                                ProviderItem(provider: provider){provider in
                                    self.providerId = Int(truncating: provider.id ?? 0)
                                    showProvider.toggle()
                                }.padding(.all,5)
                            }
                        }.onAppear{
                            prioviderModelList = data.data
                        }
                    case .error(let error):
                        ErrorDialogView(errorMessage: "\(error)")
                    }
                }.padding(.horizontal)
            }
            .onAppear{
                mainViewModel.providerList { response in
                    providerResponseState = response
                }
            }
            .fullScreenCover(isPresented: $game, content: {
                GamePagerView(){
                    game.toggle()
                    actionHome()
                }
            }).fullScreenCover(isPresented: $chat, content: {
                ChatListView(dismiss: $chat)
            }).fullScreenCover(isPresented: $setting, content: {
                SettingView(dismiss: $setting)
            }).fullScreenCover(isPresented: $showProvider, content: {
                ShowProviderView(dismiss: $showProvider, providerId: $providerId)
            })
           
        }.navigationBarBackButtonHidden()
    }
}

#Preview {
    ProviderPageView(){
        
    }
}
