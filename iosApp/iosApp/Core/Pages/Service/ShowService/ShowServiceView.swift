//
//  ShowServiceView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 14/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import ComposeApp

struct ShowServiceView: View {
    @StateObject private var mainViewModel = ViewModel()
    @StateObject private var userDataViewModel = SettingsViewModel()
    @Binding var dismiss : Bool
    @Binding var id :Int
    @State private var reviewsListResponseState : RequestState<ReviewsListService> = .idle
    @State private var serviceModelDataResponseState : RequestState<ServiceModelData> = .idle
    @State private var addOpinion:Bool = false
    @State private var likeService : Bool = false
    @State private var favoritesCount : Int = 0
    @State private var providerId : Int = -1
    @State private var showProvider : Bool = false
  
    var body: some View {
        VStack(alignment: .leading){
            TopAppBarBackView {
                dismiss.toggle()
            }
            switch serviceModelDataResponseState {
            case .idle:
                Spacer()
            case .loading:
                Spacer()
                ProgressView().onTapGesture {
                    dismiss.toggle()
                }
                Spacer()
            case .success(let data):
                ScrollView(.vertical,showsIndicators: false){
                    VStack{
                        ImageSliderView(images: HelperKt.imageList(images: data.data.service_image ?? ""))
                            .padding()
                            .frame(width: 400,height: 400)
                    }.cornerRadius(50)
                        .overlay{
                            VStack{
                                HStack{
                                    HStack{
                                        LoadingImageView(imagePath: Constants().UsersImages + "\(data.data.provider?.user?.user_image ?? "")")
                                            .frame(width: 40,height: 40)
                                            .cornerRadius(50)
                                            .padding(8)
                                        VStack{
                                            Text("\(data.data.provider?.user?.first_name ?? "") \(data.data.provider?.user?.last_name ?? "")")
                                                .bold()
                                                .font(.caption)
                                            Text("\(data.data.provider?.user?.country?.name ?? "") \(data.data.provider?.user?.city?.name ?? "")")
                                                .foregroundColor(Color.theme.logoGreen)
                                        }
                                    }.padding(.horizontal)
                                        .background{
                                            RoundedRectangle(cornerRadius: 25.0)
                                                .fill(.white.opacity(0.4))
                                        }.padding()
                                        .onTapGesture {
                                            providerId = Int(truncating: data.data.provider_id ?? -1)
                                            showProvider.toggle()
                                        }
                                    Spacer()
                                }.frame(height: 50)
                                    .frame(maxWidth: .infinity)
                                Spacer()
                                HStack{
                                    HStack{
                                        Image(systemName: "heart.fill")
                                            .resizable()
                                            .frame(width: 30,height: 30)
                                            .foregroundColor(likeService ? .red : .gray)
                                            .onTapGesture {
                                                likeService.toggle()
                                                if likeService {
                                                    favoritesCount = favoritesCount + 1
                                                    mainViewModel.setFavoriteServices(addServiceFavorite: AddServiceFavorite(service_id: Int32(truncating: data.data.id ?? 0))) { response in
                                                        response.handleState {
                                                            //Loading...
                                                        } onSuccess: { message in
                                                            print(message)
                                                        } onError: { error in
                                                            print(error)
                                                        }
                                                    }
                                                    //delete
                                                } else {
                                                    favoritesCount = favoritesCount - 1
                                                    // add favorite
                                                    mainViewModel.deleteFavoriteServices(id: "\(data.data.id ?? 0)") { response in
                                                        response.handleState {
                                                            //Loading...
                                                        } onSuccess: { message in
                                                            print(message)
                                                        } onError: { error in
                                                            print(error)
                                                        }
                                                    }
                                                }
                                            }
                                        Text("\(favoritesCount)")
                                    }.padding()
                                        .background{
                                            RoundedRectangle(cornerRadius: 25)
                                                .fill(.white)
                                        }
                                    HStack{
                                        Image(systemName: "star.fill")
                                            .resizable()
                                            .frame(width: 30,height: 30)
                                            .foregroundColor(.yellow)
                                        Text("2")
                                    }.padding()
                                        .background{
                                            RoundedRectangle(cornerRadius: 25)
                                                .fill(.white)
                                        }
                                    Spacer()
                                    Menu {
                                        Button("report".localized, action: reportSerivce)
                                    } label: {
                                        Label("", systemImage: "exclamationmark.bubble")
                                            .foregroundColor(.red)
                                            .padding()
                                            .bold()
                                    }
                                }.padding(.horizontal)
                            }
                        }
                    VStack(alignment: .leading){
                        Text("\(data.data.name ?? "")")
                            .bold()
                        
                        Text("\(data.data.description_ ?? "")")
                        
                        ArcsView(data: data.data)
                        
                        switch reviewsListResponseState {
                        case .idle:
                            Text("")
                        case .loading:
                            ProgressView()
                        case .success(let data):
                            LazyVStack(content: {
                                ForEach(data.data?.reviews ?? [], id: \.self.id) { review in
                                    ReviewItemView(review : review, userId: Int(userDataViewModel.getUserId())){
                                        mainViewModel.getReviewsServiceById(id: Int32(id)) { response in
                                            reviewsListResponseState = response
                                        }
                                    }
                                }
                            })
                        case .error(let error):
                            ErrorDialogView(errorMessage: error)
                        }
                        
                        Text("add_opinion".localized)
                            .foregroundColor(.white)
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal)
                            .background{
                                RoundedRectangle(cornerRadius: 25.0)
                                    .fill(Color.theme.logoPink)
                            }.onTapGesture {
                                addOpinion.toggle()
                            }
                    }.padding()
                }
                .onAppear{
                    self.favoritesCount = Int(truncating: data.data.favorites_count ?? 0)
                    data.data.favorites?.forEach({ f in
                        if f.user_id == KotlinInt(int: Int32(userDataViewModel.getUserId())) {
                            self.likeService.toggle()
                        }
                    })
                }
            case .error(let error):
                ErrorDialogView(errorMessage: error)
            }
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .fullScreenCover(isPresented: $addOpinion, content: {
            AddReviewView(dissmiss: $addOpinion, serviceId: "\(id)"){
                mainViewModel.getReviewsServiceById(id: Int32(id)) { response in
                    reviewsListResponseState = response
                }
            }
        }).fullScreenCover(isPresented: $showProvider, content: {
            ShowProviderView(dismiss: $showProvider, providerId: $providerId)
        })
        .navigationBarBackButtonHidden(true)
        .onAppear{
            mainViewModel.showServiceById(id: id) { response in
                serviceModelDataResponseState = response
            }
            mainViewModel.getReviewsServiceById(id: Int32(id)) { response in
                reviewsListResponseState = response
            }
        }
    }
    
    func reportSerivce() {
        // report here
        mainViewModel.sendReport(sendReport: SendReport(
            email: "\(String(describing: userDataViewModel.getUser().email))",
            contentType: "service",
            contentId: "\(String(describing: id))")) { response in
            response.handleState {
                print("Loading...")
            } onSuccess: { response in
                print("Done")
            } onError: { error in
                print("\(error)")
            }
        }
    }
}

#Preview {
    ShowServiceView(dismiss : .constant(true),id: .constant(-1))
}
