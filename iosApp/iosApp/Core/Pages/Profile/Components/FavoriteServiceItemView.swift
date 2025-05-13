//
//  FavoriteServiceItemView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 4/12/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import ComposeApp

struct FavoriteServiceItemView: View {
    var favoriteServiceModel : FavoriteServiceModel
    var openFavoriteService: (_ favoriteServiceModel : FavoriteServiceModel) -> Void
    var deleteFavoriteService: (_ favoriteServiceModel : FavoriteServiceModel) -> Void
    var body: some View {
        ZStack{
            ImageSliderView(images: (HelperKt.imageList(images: favoriteServiceModel.service?.service_image ?? "")))
                .cornerRadius(20)
                .overlay{
                    VStack{
                        Spacer()
                        HStack{
                            VStack(alignment: .leading){
                                Text("\(favoriteServiceModel.service?.name ?? "")")
                                    .foregroundColor(.white)
                                    .font(.custom(Fonts.montserrat.rawValue, size: 10))
                            }
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.vertical,12)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.theme.greenDark)
                        )
                        .overlay {
                            Image(systemName: "heart")
                                .foregroundColor(.white)
                                .padding(8)
                                .background(
                                    Circle().fill(Color.theme.logoPink)
                                )
                                .offset(x: 50,y:-35)
                                .onTapGesture {
                                    deleteFavoriteService(favoriteServiceModel)
                                }
                        }
                    }
                }.onTapGesture {
                    openFavoriteService(favoriteServiceModel)
                }
                .frame(maxWidth: .infinity,alignment: .top)
        }.frame(width: 170,height: 160)
    }
}

#Preview {
    FavoriteServiceItemView(favoriteServiceModel: FavoriteServiceModel(id: 1, service: Service_(category_id: 1, currency_id: 1, description: "", id: 1, max_price: 1, min_price: 1, name: "S", provider_id: 1, service_image: ""), service_id: 1, user: nil, user_id: 1)){ favoriteServiceModel in
        
    } deleteFavoriteService: { favoriteServiceModel in
        
    }
}
