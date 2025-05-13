//
//  GamePagerView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 26/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import ComposeApp

struct GamePagerView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var mainViewModel = ViewModel()
    @State private var gameResponseState : RequestState<GameList> = .idle
    @State private var showEndGame : Bool = false
    var action:()-> Void
    var body: some View {
        VStack(alignment: .center){
            switch gameResponseState {
            case .idle:
                Text("").hidden()
            case .loading:
                ProgressView()
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
            case .success(let data):
                VStack{
                    TopAppBarBackView {
                        presentationMode.wrappedValue.dismiss()
                    }
                    
                    PagerView(gameModelList: data.data ?? []) {
                        //done
                        showEndGame.toggle()
                    }
                }
            case .error(let error):
                Text("\(error)")
            }
        }.frame(maxWidth: .infinity,alignment: .top)
            .frame(maxHeight: .infinity)
            .onAppear{
                mainViewModel.game { response in
                    gameResponseState = response
                }
            }
            .fullScreenCover(isPresented: $showEndGame, content: {
                EndGameView(){
                    showEndGame.toggle()
                    action()
                }
            })
    }
}

#Preview {
    GamePagerView(){
        
    }
}
