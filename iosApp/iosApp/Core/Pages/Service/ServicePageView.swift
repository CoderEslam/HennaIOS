//
//  ServicePageView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 7/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import ComposeApp

struct ServicePageView: View {
    @State private var selectedCategoryID: Int32 = -1
    @StateObject private var mainViewModel = ViewModel()
    @State private var serviceResponseState : RequestState<ServiceList> = .idle
    @State private var categoryResponseState : RequestState<CategoriesList> = .idle
    @State private var filteredData: [ServiceModel] = []
    @State private var showService: Bool = false
    @State private var serviceId:Int = -1
    @State var search:String = ""
    @State private var chat = false
    @State private var game = false
    @State private var setting = false
    @State private var filter = false
    // to init items
    private let gridItems:[GridItem] = [
        .init(.flexible(),spacing: 1),
        .init(.flexible(),spacing: 1)
    ]
    var actionHome:()-> Void
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView(.vertical,showsIndicators: false){
                VStack{
                    TopAppBarView(title: "services".localized) {
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
                    VStack {
                        HStack{
                            Image("search")
                            TextField("search".localized, text: $search)
                            Image("filter_icon")
                        }.padding(.horizontal)
                            .frame(height: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke().fill(Color("logo_green"))
                            ).onChange(of: search, perform: { value in
                                mainViewModel.serviceFilter(filterService: FilterService(category_id: [], city_id: [], provider: [], from_price: 1, to_price: 60000, currency_id: [], search_input: search)) { response in
                                    response.handleState {
                                        print("Loading...")
                                    } onSuccess: { data in
                                        filteredData = data.data ?? []
                                    } onError: { error in
                                        print("\(error)")
                                    }
                                    
                                }
                            })
                        
                        switch categoryResponseState {
                        case .idle:
                            Text("")
                        case .loading:
                            ProgressView()
                        case .success(let data):
                            ScrollView(.horizontal,showsIndicators: false){
                                HStack{
                                    if selectedCategoryID != -1 {
                                        Image(systemName: "xmark.circle")
                                            .resizable()
                                            .frame(width: 25,height: 25)
                                            .padding(8).onTapGesture {
                                                withAnimation(.spring(response: 0.8,dampingFraction: 0.9)){
                                                    selectedCategoryID = -1
                                                }
                                            }
                                    }
                                    ForEach(data.data ?? [],id:\.self.id){ categoty in
                                        FilterItemCategoryView(id: $selectedCategoryID,categoryModel: categoty){ categoryModel in
                                            withAnimation(.spring(response: 0.8,dampingFraction: 0.9)){
                                                selectedCategoryID = Int32(truncating: categoryModel.id ?? -1)
                                            }
                                        }
                                    }
                                }
                            }
                        case .error(let error):
                            ErrorDialogView(errorMessage: error)
                        }
                        
                        //post gridview
                        switch serviceResponseState {
                        case .idle:
                            Text("")
                        case .loading:
                            ProgressView()
                        case .success(let data):
                            LazyVGrid(columns: gridItems ,spacing: 1){
                                ForEach(filteredData ,id: \.self.id){ service  in
                                    ServiceItemView(service: service){service in
                                        serviceId = Int(truncating: service.id ?? 0)
                                        showService.toggle()
                                    }.padding(.top,5)
                                }
                            }.onAppear{
                                if selectedCategoryID == -1 {
                                    filteredData = data.data // Show all items if no category is selected
                                }
                            }.onChange(of: selectedCategoryID, perform: { value in
                                withAnimation{
                                    if selectedCategoryID == -1 {
                                        filteredData = data.data // Show all items if no category is selected
                                    } else {
                                        filteredData = data.data.filter { Int32(truncating: $0.category_id ?? -1) == selectedCategoryID }
                                    }
                                }
                            })
                        case .error(let error):
                            ErrorDialogView(errorMessage: error)
                        }
                        
                    }
                    .padding(.horizontal)
                }
            }
            .onAppear{
                mainViewModel.serviceList { response in
                    serviceResponseState = response
                }
                mainViewModel.categoryList { response in
                    categoryResponseState = response
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
            }).fullScreenCover(isPresented: $showService, content: {
                ShowServiceView(dismiss : $showService, id: $serviceId)
            }).fullScreenCover(isPresented: $filter, content: {
                FilterView(dismiss : $filter)
            })
            Button {
                filter.toggle()
            } label: {
                // 1
                Image(systemName: "plus")
                    .font(.title.weight(.semibold))
                    .padding()
                    .background(Color.pink)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .shadow(radius: 4, x: 0, y: 4)
            }.offset(y:-100)
                .padding()
        }.navigationBarBackButtonHidden()
    }
}

#Preview {
    ServicePageView(){
        
    }
}

