//
//  ServiceFilterView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 18/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import ComposeApp

struct ServiceFilterView: View {
    var serviceModelList:[ServiceModel]
    @Binding var filterService:Bool
    @State private var showService: Bool = false
    @State private var serviceId:Int = -1
    private let gridItems:[GridItem] = [
        .init(.flexible(),spacing: 1),
        .init(.flexible(),spacing: 1)
    ]
    var body: some View {
        NavigationView{
            ScrollView(.vertical,showsIndicators: false){
                VStack{
                    TopAppBarBackView {
                        filterService.toggle()
                    }
                    LazyVGrid(columns: gridItems ,spacing: 1){
                        ForEach(serviceModelList ,id: \.self.id){ service  in
                            ServiceItemView(service: service){service in
                                serviceId = Int(truncating: service.id ?? 0)
                                showService.toggle()
                            }.padding(.top,5)
                        }
                    }
                }
            }.fullScreenCover(isPresented: $showService, content: {
                ShowServiceView(dismiss: $showService, id: $serviceId)
            })
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ServiceFilterView(serviceModelList: [ServiceModel(category: Category(category_image: "", id: 1, name: "", user_id: 2), category_id: 1, currency: CurrencyModel(id: 1, name: "", user_id: 1), currency_id: 1, description: "", favorites: nil, favorites_count: 1, id: 1, max_price: 1, min_price: 1, name: "", provider: nil, provider_id: 1, reviews: nil, reviews_count: 1, service_image: "")],filterService:.constant(false))
}
