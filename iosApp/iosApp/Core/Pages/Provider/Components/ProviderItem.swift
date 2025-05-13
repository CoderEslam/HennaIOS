//
//  ProviderItem.swift
//  HennaApp
//
//  Created by Eslam Ghazy on 25/9/23.
//

import SwiftUI
import ComposeApp

struct ProviderItem: View {
    var provider: ProviderModel
    var action:(_ provider: ProviderModel)-> Void
    var body: some View {
        ZStack{
            LoadingImageView(imagePath: Constants().UsersImages +  (provider.user?.user_image ?? ""))
                .cornerRadius(20)
                .frame(width: 170,height: 150)
                .overlay{
                    VStack{
                        Spacer()
                        VStack{
                            Text("\(provider.user?.first_name ?? "") \(provider.user?.last_name ?? "")")
                                .foregroundColor(.white)
                                .font(.custom(Fonts.montserrat.rawValue, size: 14))
                                .lineLimit(1)
                            Text("\(provider.user?.country?.name ?? "") \(provider.user?.city?.name ?? "")")
                                .foregroundColor(.white)
                                .font(.custom(Fonts.montserrat.rawValue, size: 12))
                                .lineLimit(1)
                        }.frame(maxWidth: .infinity)
                        .padding()
                        .background{
                            RoundedRectangle(cornerRadius: 50)
                                .fill(Color.theme.greenDark.opacity(0.8))
                                .frame( height: 55)
                        }
                    }
                    .padding(.horizontal)
                }.onTapGesture {
                    action(provider)
                }
        }
    }
}

struct ProviderItem_Previews: PreviewProvider {
    static var previews: some View {
        ProviderItem(provider: ProviderModel(brand_name: "", id: 1, provider_bio: "", services_count: 1, user: User(background_image: "", city: CityModel(id: 1, name: "city", province_id: 1), city_id: 1, country: CountryModel(id: 1, name: "country", provinces: nil), country_id: 1, device_token: "", email: "", first_name: "Eslam", id: 1, interests: nil, language: nil, language_id: 1, last_name: "Ghazy", phone: "", phone_extension: "", province: nil, province_id: 1, user_image: "", provider: Provider(brand_name: "", id: -1, provider_bio: "", registration_number: "", user_id: -1)), user_id: 1)){provider in
            
        }
    }
}
