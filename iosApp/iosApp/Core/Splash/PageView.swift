//
//  PageView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 7/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct PageView: View {
    @StateObject private var userDate = SettingsViewModel()
    var page : PageModel
    var body: some View {
        ZStack{
            Image("\(page.imageUrl)")
                .resizable()
                .frame(maxWidth: .infinity)
                .frame(maxHeight: .infinity)
            VStack{
                Spacer()
                Spacer()
                Image("v_logo")
                Text(page.name)
                    .foregroundColor(.white)
                    .bold()
                    .padding(.top,20)
                Spacer()
                NavigationLink{
                    AuthView()
                } label: {
                    Text("get_start".localized)
                        .foregroundColor(Color(hex: "#CBD5E1").opacity(0.8))
                        .padding(.horizontal,100)
                        .padding(.vertical,20)
                        .background(
                            RoundedRectangle(cornerRadius: 50)
                                .stroke()
                                .fill(Color(hex: "#CBD5E1"))
                        )
                }
                NavigationLink{
                    HomeView()
                } label: {
                    Text("login_as_guest".localized)
                        .onTapGesture{
                            userDate.loginAsGuest()
                        }
                        .foregroundColor(Color(hex: "#CBD5E1").opacity(0.8))
                        .padding(.horizontal,100)
                        .padding(.vertical,20)
                        .background(
                            RoundedRectangle(cornerRadius: 50)
                                .stroke()
                                .fill(Color(hex: "#CBD5E1"))
                        )
                }
                Spacer()
                Text(page.description)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding(.horizontal,20)
                Spacer()
            }.frame(maxWidth: .infinity,alignment: .center)
            
        }.frame(maxWidth: .infinity)
            .frame(maxHeight: .infinity)
            .ignoresSafeArea()
            .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    PageView(page: PageModel(name: "\"Exceeding your wedding expectations\"", description: "\"Welcome to our wedding services app, where we help make your dream wedding a reality.\"", imageUrl: "i1", tag: 0))
}
