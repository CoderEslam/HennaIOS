//
//  EndGameView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 26/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import ComposeApp

struct EndGameView: View {
    @State private var gameViewModel = GameViewModel()
    @State private var providerResponseState : RequestState<ProviderList> = .idle
    @State private var providerRandomResponseState : RequestState<RandomProvider> = .idle
    @State private var userResponseState : RequestState<UserModel> = .idle
    @State private var showProvider:Bool = false
    @State private var providerId:Int = -1
    var action:() -> Void
    var body: some View {
        VStack{
            TopAppBarBackView {
                action()
            }
            switch userResponseState {
            case .idle:
                Text("")
            case .loading:
                ProgressView()
            case .success(let data):
                ScrollView(.vertical,showsIndicators: false){
                    VStack(alignment: .center){
                        LoadingImageView(imagePath: Constants().USER_IMAGE + (data.data?.user_image ?? ""))
                            .cornerRadius(25)
                            .frame(width: 150,height: 150)
                            
                        HStack {
                            Text("congratulations".localized)
                                .font(.system(size: 18))
                            Text("\(data.data?.first_name ?? "") \(data.data?.last_name ?? "")")
                                .font(.system(size: 16))
                            Text("you_win".localized)
                                .font(.system(size: 18))
                        }.bold()
                        .foregroundColor(Color.theme.logoGreen)
                        HStack{
                            Text("now_you_have".localized).font(.system(size: 18))
                            Text("10_points".localized)
                                .font(.system(size: 18))
                                .foregroundColor(Color.theme.logoGreen)
                        }
                        Text("your_wedding_will_be_like".localized)
                            .font(.system(size: 18))
                            .foregroundColor(Color.theme.logoGreen)
                        Image(imagesList.shuffled().first ?? "")
                            .resizable()
                            .frame(width: .infinity,height: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                    }
                }
            case .error(let error):
                ErrorDialogView(errorMessage: "\(error)")
            }
            
            
            VStack{
                switch providerRandomResponseState {
                case .idle:
                    Text("")
                case .loading:
                    ProgressView()
                case .success(let data):
                    Text("these_vendors_have_organized_your_wedding".localized)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    ScrollView(.horizontal,showsIndicators: false){
                        HStack{
                            ForEach(data.data,id: \.self.id){ provider  in
                                ProviderItem(provider: provider.fromRandomProviderModelToProviderModel()){ provider in
                                    self.providerId = Int(truncating: provider.id ?? 0)
                                    self.showProvider.toggle()
                                }.padding(.all,5)
                            }
                        }
                    }
                case .error(let error):
                    ErrorDialogView(errorMessage: "\(error)")
                }
            }
        }
        //.showLoader(loading: $gameViewModel.state.isLoading)
        .showErrorDialog(showError: $gameViewModel.state.showError, rawErrorMessage: gameViewModel.state.error)
        .fullScreenCover(isPresented: $showProvider, content: {
            ShowProviderView(dismiss: $showProvider, providerId: $providerId)
        })
        .onAppear{
            gameViewModel.providerList{ response in
                providerRandomResponseState = response
            }
            gameViewModel.showUser{ response in
                userResponseState = response
            }
        }
    }
}

#Preview {
    EndGameView(){
        
    }
}


var imagesList = [
    "ahmet_tansu_tasanlar",
    "berguzar_korel",
    "burak_ocivit",
    "cristiano_ronaldo",
    "donia_botazote",
    "farah_fassi",
    "fatima_khire",
    "hazal_kaya",
    "jennifer_lopez",
    "justin_bieber",
    "kemal_dogulu",
    "lady_gaga",
    "lionel_messi",
    "lman_elbani",
    "manal_benchlikha",
    "muslim",
    "ozge_gurel",
    "principe_harry",
    "rosalia",
    "taner_olmez"
]
