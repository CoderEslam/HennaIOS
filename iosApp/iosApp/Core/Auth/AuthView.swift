//
//  AuthView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 7/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct AuthView: View {
    @State private var selectedTab: Int = 0

        let tabs: [Tab] = [
            .init(icon: Image(systemName: ""), title: "login".localized),
            .init(icon: Image(systemName: ""), title: "create_account".localized)
        ]

        init() {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(#colorLiteral(red: (175/255), green: (201/255), blue: (192/255), alpha: 1))
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
            UINavigationBar.appearance().isTranslucent = false
        }
    
    var body: some View {
        VStack(alignment: .center){
            VStack{
                Image("h_logo")
                Text("\"Exceeding your wedding \nexpectations\"".localized)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(hex: "#89A59E"))
                    .font(.custom("Montserrat", size: 16))
                
            }.padding(.top,20)
            VStack{
                GeometryReader { geo in
                    VStack(spacing: 0) {
                        // Tabs
                        Tabs(tabs: tabs, geoWidth: geo.size.width, selectedTab: $selectedTab)
                        
                        // Views
                        TabView(selection: $selectedTab, content: {
                            LoginView().tag(0)
                            CreateAccountView().tag(1)
                        })
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .ignoresSafeArea()
                }
            }
            .background(.gray.opacity(0.1))
            .padding(.top)
        }
        .background(.gray.opacity(0.1))
        .navigationBarBackButtonHidden()
        .navigationViewStyle(StackNavigationViewStyle())
        //.ignoresSafeArea()
    }
}

#Preview {
    AuthView()
}
