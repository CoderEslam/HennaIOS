//
//  FavoriteServiceView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 18/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import ComposeApp

struct FavoriteServiceView: View {
    @StateObject private var favoriteServiceViewModel = FavoriteServiceViewModel()
    @State private var showService: Bool = false
    @State private var serviceId:Int = -1
    var user : User
    private let gridItems:[GridItem] = [
        .init(.flexible(),spacing: 1),
        .init(.flexible(),spacing: 1)
    ]
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            VStack{
                LazyVGrid(columns: gridItems,spacing: 1){
                    ForEach(favoriteServiceViewModel.state.favoriteServiceList?.data ?? [] ,id: \.self.id){ service  in
                        FavoriteServiceItemView(favoriteServiceModel: service) { favoriteServiceModel in
                            serviceId = Int(truncating: favoriteServiceModel.service_id ?? 0)
                            showService.toggle()
                        } deleteFavoriteService: { favoriteServiceModel in
                            
                        }.padding(.top,5)
                    }
                }
            }
        }.showLoader(loading: $favoriteServiceViewModel.state.isLoading)
            .showErrorDialog(showError: $favoriteServiceViewModel.state.showError, rawErrorMessage: favoriteServiceViewModel.state.error)
        .onAppear{
            favoriteServiceViewModel.getFavoriteService()
        }.fullScreenCover(isPresented: $showService, content: {
            ShowServiceView(dismiss : $showService, id: $serviceId)
        })
    }
}

#Preview {
    FavoriteServiceView(user: User(background_image: "", city: CityModel(id: 1, name: "city", province_id: 1), city_id: 1, country: CountryModel(id: 1, name: "country", provinces: [ProvincesModel(cities: [CityModel(id: 1, name: "", province_id: 1)], country_id: 1, id: 1, name: "")]), country_id: 1, device_token: "", email: "eslam@gmmail.com", first_name: "", id: 1, interests: [InterestsModel(category: CategoryModel(category_image: "", id: 1, name: "", services: nil, services_count: 1), category_id: 1, id: 1, user_id: 1)], language: nil, language_id: 2, last_name: "ESlam", phone: "123456789", phone_extension: "", province: ProvincesModel(cities: [CityModel(id: 1, name: "city", province_id: 1)], country_id: 1, id: 1, name: ""), province_id: 1, user_image: "", provider: Provider(brand_name: "", id: -1, provider_bio: "", registration_number: "", user_id: -1)))
}
