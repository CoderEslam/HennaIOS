//
//  HomeView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 7/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import ComposeApp

struct HomeView: View {
    @StateObject private var userData = SettingsViewModel()
    @State var selectedTab : TabBottom = .home
    private var tabItems = [
        TabItems(name: "profile".localized, icon: "profile_icon",tab: .profile, color:  Color("logo_pink") ),
        TabItems(name: "posts".localized, icon: "game_icon",tab: .posts, color:  Color("logo_pink")),
        TabItems(name: "home".localized, icon: "home_icon",tab: .home, color: Color("logo_green")),
        TabItems(name: "service".localized, icon: "service_icon",tab: .service, color:  Color("logo_pink")),
        TabItems(name: "provider".localized, icon: "provider_icon",tab: .provider, color:  Color("logo_pink"))
    ]
    @State var color :Color = Color("logo_green")
    var body: some View {
        ZStack(alignment: .bottom){
            Group{
                switch selectedTab {
                case .home:
                    HomePageView(){
                        withAnimation{
                            selectedTab = .home
                        }
                    }
                case .profile:
                    if userData.token != "" {
                        if userData.getProvider() != Provider(brand_name: "", id: -1, provider_bio: "", registration_number: "", user_id: -1) {
                            ProfilePageView(){
                                withAnimation{
                                    selectedTab = .home
                                }
                            }
                            
                        } else {
                            ProfileProviderPageView(){
                                withAnimation{
                                    selectedTab = .home
                                }
                            }
                        }
                    } else {
                        ProfileProviderPageView(){
                            withAnimation{
                                selectedTab = .home
                            }
                        }
                    }
                    
                case .service:
                    ServicePageView(){
                        withAnimation{
                            selectedTab = .home
                        }
                    }.padding(.bottom,32)
                case .provider:
                    ProviderPageView(){
                        withAnimation{
                            selectedTab = .home
                        }
                    }.padding(.bottom,32)
                case .posts:
                    PostsPageView(){
                        withAnimation{
                            selectedTab = .home
                        }
                    }.padding(.bottom,32)
                }
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .padding(.bottom,50)
            
            HStack{
                HStack{
                    ForEach(tabItems) { item in
                        Button{
                            withAnimation(.spring(response: 0.3,dampingFraction: 0.5)){
                                selectedTab = item.tab
                                color = item.color
                            }
                        }label: {
                            VStack(spacing: 0){
                                Image(item.icon)
                                    .symbolVariant(.fill)
                                    .font(.body.bold())
                                    .frame(width: 44, height: 29)
                                Text(item.name)
                                    .foregroundColor(.black)
                                    .font(.caption2)
                                    .lineLimit(1)
                                
                            }.frame(maxWidth: .infinity)
                        }.foregroundColor(selectedTab == item.tab ? .primary : .secondary)
                    }
                }
                .padding(.horizontal,8)
                .padding(.top,14)
                .frame(height: 88,alignment: .top)
                .background(.ultraThinMaterial,in:RoundedRectangle(cornerRadius: 34,style: .continuous))
                .background(
                    HStack{
                        if selectedTab == .service {
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                        }
                        if selectedTab == .provider {
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                        }
                        if selectedTab == .home {
                            Spacer()
                            Spacer()
                        }
                        
                        if selectedTab == .posts {
                            Spacer()
                        }
                        Circle().fill(color).frame(width: 80)
                        
                        if selectedTab == .home {
                            Spacer()
                            Spacer()
                        }
                        if selectedTab == .service {
                            Spacer()
                        }
                        if selectedTab == .profile {
                            Spacer()
                        }
                        if selectedTab == .posts {
                            Spacer()
                            Spacer()
                            Spacer()
                        }
                    }.padding(.horizontal,8)
                )
                .overlay(
                    HStack{
                        if selectedTab == .service {
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                        }
                        if selectedTab == .provider {
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                        }
                        if selectedTab == .home {
                            Spacer()
                            Spacer()
                        }
                        
                        if selectedTab == .posts {
                            Spacer()
                        }
                        Rectangle().fill(color).frame(width: 28,height: 5)
                            .cornerRadius(3)
                            .frame(width: 88)
                            .frame(maxHeight: .infinity , alignment:.top)
                        if selectedTab == .home {
                            Spacer()
                            Spacer()
                        }
                        if selectedTab == .service {
                            Spacer()
                        }
                        if selectedTab == .profile {
                            Spacer()
                        }
                        if selectedTab == .posts {
                            Spacer()
                            Spacer()
                            Spacer()
                        }
                    }
                )
                .frame(maxWidth: .infinity,alignment: .bottom)
            }
            .padding()
        }.padding(.top)
            .ignoresSafeArea()
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    HomeView()
}


enum TabBottom {
    case home
    case profile
    case service
    case provider
    case posts
}

struct TabItems : Identifiable {
    var id = UUID()
    var name:String
    var icon :String
    var tab : TabBottom
    var color : Color
}
