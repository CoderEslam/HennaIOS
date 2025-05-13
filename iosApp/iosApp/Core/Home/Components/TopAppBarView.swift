//
//  TopAppBarView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 12/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import ComposeApp

struct TopAppBarView: View {

    var title:String
    let chat:() -> Void
    let game:() -> Void
    let home:() -> Void
    let menu:() -> Void
    var body: some View {
        ZStack{
            HStack{
                Text(title)
                    .bold()
                    .foregroundColor(.black)
            }
            HStack {
                Image("h_logo")
                    .resizable()
                    .frame(width: 150,height: 50)
                    .onTapGesture {
                        home()
                    }
                Spacer()

                GameIconView{
                    game()
                }
                .padding(8)
                .frame(width: 40, height: 40)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke().fill(Color.theme.logoGreen)
                )
                ChatIconView{
                    chat()
                }
                .padding(8)
                .frame(width: 40, height: 40)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke().fill(Color.theme.logoGreen)
                )
                Image("menu")
                    .padding()
                    .frame(width: 40, height: 40)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke().fill(Color.theme.logoGreen)
                    )
                    .onTapGesture {
                        menu()
                    }
            }
        }
    }
}

#Preview {
    TopAppBarView(
        title: "Home", chat: {
        print("dhipjeipthjiajhop 1")
    }, game: {
        print("dhipjeipthjiajhop 2")
    }, home: {
        print("dhipjeipthjiajhop 3")
    },menu: {
        print("dhipjeipthjiajhop 4")
    })
}



struct ChatIconView : UIViewControllerRepresentable {
    let action:()-> Void
    func makeUIViewController(context: Context) -> UIViewController {
        MainViewControllerKt.ChatIcon{
            action()
        }
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}



struct GameIconView : UIViewControllerRepresentable {
    let action:()-> Void
    func makeUIViewController(context: Context) -> UIViewController {
        MainViewControllerKt.GameIcon{
            action()
        }
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
