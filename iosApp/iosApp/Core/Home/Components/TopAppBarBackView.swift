//
//  TopAppBarBackView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 14/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct TopAppBarBackView: View {
    var action:()->Void
    var body: some View {
        HStack{
            HStack{
                Image(systemName: "chevron.left")
                Text("back".localized)
            }.bold()
                .foregroundColor(.black)
                .onTapGesture {
                    withAnimation{
                        action()
                    }
                }
            Spacer()
        }.padding(.horizontal)
    }
}

#Preview {
    TopAppBarBackView(){
        
    }
}
