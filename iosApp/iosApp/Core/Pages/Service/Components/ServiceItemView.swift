//
//  ServiceItemView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 7/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import ComposeApp

struct ServiceItemView: View {
    @StateObject private var mainViewModel = ViewModel()
    @StateObject private var userDataViewModel = SettingsViewModel()
    @State private var showEditService : Bool = false
    @State var selected : Int = 0
    var service: ServiceModel
    var action:(_ service: ServiceModel) -> Void
    var body: some View {
        ZStack{
            LoadingImageView(imagePath: (Constants().ServiceImages + ((HelperKt.imageList(images: "\(service.service_image ?? "")")).first ?? "")))
                
//            ImageSliderView(images: (HelperKt.imageList(images: service.service_image ?? "")))
                .cornerRadius(20)
                .overlay{
                    VStack{
                        HStack{
                            HStack{
                                LoadingImageView(imagePath: Constants().UsersImages +  (service.provider?.user?.user_image ?? ""))
                                    .frame(width: 16,height: 16)
                                    .clipShape(Circle())
                                Text("\(service.provider?.brand_name ?? "")")
                                    .foregroundColor(.white)
                                    .font(.custom(Fonts.montserrat.rawValue, size:10))
                                    .lineLimit(1)
                            }
                            .padding(3)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.theme.greenDark)
                            )
                            .padding(8)
                            Spacer()
                            if Int(truncating: service.provider_id ?? -1) == userDataViewModel.getProviderId() {
                                Menu {
                                    Button("edit".localized, action: editService)
                                    Button("delete".localized, action: deleteService)
                                } label: {
                                    Label("", systemImage: "ellipsis")
                                        .foregroundColor(.black)
                                        .rotationEffect(.degrees(90))
                                        .padding(8)
                                        .bold()
                                }
                            }
                        }
                        Spacer()
                        
                        HStack{
                            VStack(alignment: .leading){
                                Text("\(service.name ?? "")")
                                    .foregroundColor(.white)
                                    .font(.custom(Fonts.montserrat.rawValue, size: 10))
                                    .lineLimit(1)
                                RatingView(selected: .constant(totalRate(r: service.reviews ?? [], reviewsCount: Int(truncating: service.reviews_count ?? 0))), width: 10 ,height: 10)
                                Text("\(service.provider?.user?.country?.name ?? "") \(service.provider?.user?.city?.name ?? "")")
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
                                    
                                }
                        }
                    }
                    .onTapGesture{
                        action(service)
                    }
                }
                .frame(maxWidth: .infinity,alignment: .top)
        }.frame(width: 170,height: 160)
            .fullScreenCover(isPresented: $showEditService) {
                AddServiceView(dismiss: $showEditService, serviceId: Int(truncating: service.id ?? -1))
            }
    }
    
    private func totalRate(r: [Review], reviewsCount: Int) -> Int {
        guard reviewsCount > 0 else { return 0 } // Avoid division by zero
        var total = 0
        r.forEach { review in
            total += Int(truncating: review.rate ?? 0)
        }
        return total / reviewsCount
    }
    
    func editService() {
        showEditService.toggle()
    }
    
    func deleteService() {
        mainViewModel.deleteService(id: "\(String(describing: service.id ?? -1))") { response in
            response.handleState {
                print("Loading...")
            } onSuccess: { message in
                print("\(message)")
            } onError: { error in
                print("\(error)")
            }
        }
    }
    
}

#Preview {
    ServiceItemView(service: ServiceModel(category: nil, category_id: 1, currency: nil, currency_id: 1, description: "", favorites: nil, favorites_count: 1, id: 1, max_price: 1, min_price: 1, name: "Makeup", provider: nil, provider_id: 1, reviews: nil, reviews_count: 1, service_image: "https://letsenhance.io/static/73136da51c245e80edc6ccfe44888a99/1015f/MainBefore.jpg")){s in
        
    }
}

