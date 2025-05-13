//
//  ProviderServicePageView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 16/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import ComposeApp

struct ProviderServicePageView: View {
    @StateObject private var userDataViewModel = SettingsViewModel()
    @State private var showService: Bool = false
    @State private var addService: Bool = false
    @State private var id:Int = -1
    var data: ProviderModel_
    private let gridItems:[GridItem] = [
        .init(.flexible(),spacing: 1),
        .init(.flexible(),spacing: 1)
    ]
    var body: some View {
        ScrollView{
            VStack(alignment: .center){
                if userDataViewModel.getProvider() != nil {
                    HStack{
                        Image("add_service")
                            .resizable()
                            .frame(width: 20,height: 20)
                            .padding(4)
                            .background{
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white)
                            }
                        Text("add_new_service".localized)
                            .foregroundColor(Color.theme.greenDark)
                            .padding(.horizontal,4)
                        Spacer()
                    }.frame(maxWidth: .infinity)
                        .padding(4)
                        .background{
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.theme.greenDark.opacity(0.5))
                        }.onTapGesture{
                            addService.toggle()
                        }
                }
                LazyVGrid(columns: gridItems ,spacing: 1){
                    ForEach(data.services ?? [] ,id: \.self.id){ service  in
                        ServiceItemView(service: service){service in
                            id = Int(truncating: service.id ?? 0)
                            showService.toggle()
                        }.padding(.top,5)
                    }
                }
            }.fullScreenCover(isPresented: $showService, content: {
                ShowServiceView(dismiss: $showService, id: $id)
            })
            .fullScreenCover(isPresented: $addService, content: {
                AddServiceView(dismiss: $addService)
            })
        }
    }
}

#Preview {
    ProviderServicePageView(data: ProviderModel_(brand_name: "", id: 1, provider_bio: "", services: nil, user: nil, user_id: 1))
}
