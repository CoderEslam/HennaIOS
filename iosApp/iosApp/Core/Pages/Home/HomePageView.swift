//
//  HomePageView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 7/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import ComposeApp
struct HomePageView: View {
    @StateObject private var mainViewModel = ViewModel()
    @State private var providerResponseState : RequestState<ProviderList> = .idle
    @State private var serviceResponseState : RequestState<ServiceList> = .idle
    @State private var filterServiceResponseState : RequestState<FilterList> = .idle
    @State private var categoryResponseState : RequestState<CategoriesList> = .idle
    @State private var advResponseState : RequestState<AdvertisementList> = .idle
    @State private var homeSearchResponseState : RequestState<HomeCallback> = .idle
    @State private var serviceId:Int = -1
    @State private var showService: Bool = false
    @State private var showProvider:Bool = false
    @State private var providerId:Int = -1
    @State private var currentPage = 0
    @State private var filterService : Bool = false
    @State private var chat = false
    @State private var game = false
    @State private var setting = false
    @State var search: String = ""
    let pages = [Color.red, Color.blue, Color.green,Color.cyan,Color.orange,Color.yellow]
    var actionHome:()-> Void
    
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            VStack(alignment: .leading){
                TopAppBarView(title: "home".localized) {
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
                }.padding(.top,32)
                    .padding(.bottom,8)
                VStack{
                    HStack{
                        Image("search")
                        TextField("search".localized, text: $search)
                        Image("filter_icon")
                    }.padding(.horizontal)
                        .frame(height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke().fill(Color("logo_green"))
                        ).onChange(of: search, perform: { newValue in
                            if newValue != "" {
                                mainViewModel.homeSearch(name: newValue) { response in
                                    homeSearchResponseState = response
                                }
                            } else {
                                homeSearchResponseState = .idle
                            }
                        })
                    ZStack(alignment: .top){
                        
                        VStack{
                            switch categoryResponseState {
                            case .idle:
                                Text("").hidden()
                            case .loading:
                                HStack{
                                    ProgressView()
                                }.frame(maxWidth: .infinity)
                            case .success(let data):
                                VStack{
                                    Text("our_categories".localized)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    ScrollView(.horizontal,showsIndicators: false){
                                        HStack{
                                            ForEach(data.data ?? [],id:\.self.id){ categoty in
                                                CategoryItemView(categoryModel: categoty).onTapGesture {
                                                    filterService.toggle()
                                                    mainViewModel.serviceFilter(filterService: FilterService(category_id: [KotlinInt(int: Int32(truncating: categoty.id ?? 0))], city_id: [], provider: [], from_price: 1, to_price: 60000, currency_id: [], search_input: "")) { response in
                                                        filterServiceResponseState = response
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            case .error(let error):
                                ErrorDialogView(errorMessage: "\(error)")
                            }
                            
//                            switch advResponseState {
//                            case .idle:
//                                Text("").hidden()
//                            case .loading:
//                                ProgressView()
//                            case .success(let data):
//                                VStack {
//                                    TabView(selection: $currentPage) {
//                                        ForEach(data.data, id: \.self.id) { adv in
//                                            LoadingImageView(imagePath: Constants().AdvertisementImages + adv.advertisement_content)
//                                                .frame(width: .infinity,height: 300)
//                                                .background{
//                                                    RoundedRectangle(cornerRadius: 20)
//                                                        .frame(width: .infinity,height: 300)
//                                                }
//                                        }
//                                    }
//                                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
//                                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
//                                    .onAppear {
//                                        startAutoScroll(pages.count)
//                                    }
//                                }
//                                .cornerRadius(20)
//                                .frame(height: 180)
//                            case .error(let error):
//                                ErrorDialogView(errorMessage: "\(error)")
//                            }
                            
                            switch serviceResponseState {
                            case .idle:
                                Text("").hidden()
                            case .loading:
                                HStack{
                                    ProgressView()
                                }.frame(maxWidth: .infinity)
                            case .success(let data):
                                VStack{
                                    Text("top_services".localized)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    ScrollView(.horizontal,showsIndicators: false){
                                        HStack{
                                            ForEach(data.data ,id: \.self.id){ service  in
                                                ServiceItemView(service: service){service in
                                                    self.showService.toggle()
                                                    self.serviceId = Int(truncating: service.id ?? 0)
                                                    
                                                }.padding(.top,5)
                                            }
                                        }
                                    }
                                }
                            case .error(let error):
                                ErrorDialogView(errorMessage: "\(error)")
                            }
                            
                            switch providerResponseState {
                            case .idle:
                                Text("").hidden()
                            case .loading:
                                HStack{
                                    ProgressView()
                                }.frame(maxWidth: .infinity)
                            case .success(let data):
                                VStack{
                                    Text("top_providers".localized)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    ScrollView(.horizontal,showsIndicators: false){
                                        HStack{
                                            ForEach(data.data,id: \.self.id){ provider  in
                                                ProviderItem(provider: provider){provider in
                                                    self.providerId = Int(truncating: provider.id ?? 0)
                                                    self.showProvider.toggle()
                                                }.padding(.all,5)
                                            }
                                        }
                                    }
                                }
                                
                            case .error(let error):
                                ErrorDialogView(errorMessage: "\(error)")
                            }
                        }

                        switch homeSearchResponseState {
                        case .idle:
                            Text("").hidden()
                        case .loading:
                            ProgressView()
                        case .success(let data):
                            if search != "" {
                                ScrollView(.vertical,showsIndicators: false){
                                    LazyVStack(content: {
                                        ForEach(data.data ?? [], id: \.self) { name in
                                            Text("\(name.first_name ?? "") \(name.last_name ?? "")")
                                                .frame(maxWidth: .infinity)
                                                .frame(height: 40)
                                                .background{
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .fill(Color.white)
                                                }.onTapGesture {
                                                    if name.flag == 0 {
                                                        showProvider.toggle()
                                                        providerId = Int(truncating: name.id ?? -1)
                                                    } else {
                                                        showService.toggle()
                                                        serviceId = Int(truncating: name.id ?? -1)
                                                    }
                                                }
                                        }
                                    })
                                }.frame(maxWidth: .infinity)
                                    .frame(height: 300)
                            }
                        case .error(let error):
                            ErrorDialogView(errorMessage: "\(error)")
                        }
                    }
                    
                }.padding()
            }
        }
        .onAppear{
            mainViewModel.categoryList { response in
                categoryResponseState = response
                if response.isSuccess{
                    mainViewModel.serviceList { response in
                        serviceResponseState = response
                        if response.isSuccess{
                            mainViewModel.providerList { response in
                                providerResponseState = response
                            }
                        }
                    }
                }
            }
            //            mainViewModel.getAdv { response in
            //                advResponseState = response
            //            }
        }.fullScreenCover(isPresented: $filterService, content: {
            VStack{
                switch filterServiceResponseState {
                case .idle:
                    Text("").hidden()
                case .loading:
                    ProgressView()
                case .success(let data):
                    ServiceFilterView(serviceModelList: data.data ?? [],filterService:$filterService)
                case .error(let error):
                    ErrorDialogView(errorMessage: "\(error)")
                }
            }
        }).fullScreenCover(isPresented: $game, content: {
            GamePagerView(){
                game.toggle()
                actionHome()
            }
        }).fullScreenCover(isPresented: $chat, content: {
            ChatListView(dismiss: $chat)
        }).fullScreenCover(isPresented: $setting, content: {
            SettingView(dismiss: $setting)
        }).fullScreenCover(isPresented: $showService, content: {
            ShowServiceView(dismiss: $showService, id: $serviceId)
        }).fullScreenCover(isPresented: $showProvider, content: {
            ShowProviderView(dismiss: $showProvider, providerId: $providerId)
        })
        
    }
    
    func startAutoScroll(_ size:Int) {
        let timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
            withAnimation {
                currentPage  = (currentPage  + 1) % size
            }
        }
        timer.fire()
    }
}

#Preview {
    HomePageView(){
        
    }
}
