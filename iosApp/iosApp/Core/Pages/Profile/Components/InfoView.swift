//
//  InfoView.swift
//  HennaApp
//
//  Created by Eslam Ghazy on 26/9/23.
//

import SwiftUI
import ComposeApp

struct InfoView: View {
    var user : User
    @State private var showIntersts:Bool = false
    // to init items
    private let gridItems:[GridItem] = [
        .init(.flexible(),spacing: 1),
        .init(.flexible(),spacing: 1),
        .init(.flexible(),spacing: 1)
    ]
    var body: some View {
        VStack{
            ScrollView(.vertical){
                VStack(alignment: .leading){
                    ScrollView(.horizontal){
                        VStack(alignment: .leading){
                            HStack{
                                Image("phone_icon")
                                Text("numbers_is".localized)
                                    .foregroundColor(Color.theme.logoPink)
                                    .font(.system(size: 16))
                                Text("\(user.phone ?? "")")
                                    .foregroundColor(.black)
                                    .font(.system(size: 16))
                            }
                            HStack{
                                Image("mail_icon")
                                Text("email_is".localized)
                                    .foregroundColor(Color.theme.logoPink)
                                    .font(.system(size: 16))
                                Text("\(user.email ?? "")")
                                    .foregroundColor(.black)
                                    .font(.system(size: 16))
                            }
                            HStack{
                                Image("lives_in_icon")
                                Text("lives_in".localized)
                                    .foregroundColor(Color.theme.logoPink)
                                    .font(.system(size: 16))
                                Text("\(user.country?.name ?? "") ,\(user.city?.name ?? "")")
                                    .foregroundColor(.black)
                                    .font(.system(size: 16))
                            }
                        }
                        
                    }
                    HStack{
                        Text("interests".localized)
                            .padding(.top,5)
                            .foregroundColor(Color.theme.logoPink)
                            .font(.system(size: 16))
                        Spacer()
                        Image(systemName: "plus")
                            .resizable()
                            .foregroundColor(Color.theme.logoPink)
                            .frame(width: 20,height: 20)
                            .onTapGesture {
                                showIntersts.toggle()
                            }
                    }
                    VStack{
                        if let interests = user.interests, !interests.isEmpty {
                            LazyVGrid(columns: gridItems, spacing: 1) {
                                ForEach(interests.compactMap { $0 }, id: \.id) { interest in
                                    if let category = interest.category {
                                        InterestItemView(categoryModel: category)
                                            .padding(.bottom)
                                    }
                                }
                            }
                        }
                    }
                }
                .fullScreenCover(isPresented: $showIntersts, content: {
                    InterestsListView(showIntersts:$showIntersts,interestsList: user.interests ?? [])
                })
            }
        }
        .padding(.horizontal)
        
    }
}

#Preview {
    InfoView(user: User(background_image: "", city: CityModel(id: 1, name: "city", province_id: 1), city_id: 1, country: CountryModel(id: 1, name: "country", provinces: [ProvincesModel(cities: [CityModel(id: 1, name: "", province_id: 1)], country_id: 1, id: 1, name: "")]), country_id: 1, device_token: "", email: "eslam@gmmail.com", first_name: "", id: 1, interests: [InterestsModel(category: CategoryModel(category_image: "", id: 1, name: "Hello", services: nil, services_count: 1), category_id: 1, id: 1, user_id: 1)], language: nil, language_id: 2, last_name: "ESlam", phone: "123456789", phone_extension: "", province: ProvincesModel(cities: [CityModel(id: 1, name: "city", province_id: 1)], country_id: 1, id: 1, name: ""), province_id: 1, user_image: "", provider: Provider(brand_name: "", id: -1, provider_bio: "", registration_number: "", user_id: -1)))
}
