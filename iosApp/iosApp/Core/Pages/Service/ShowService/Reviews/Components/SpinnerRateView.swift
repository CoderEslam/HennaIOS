//
//  SpinnerRateView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 14/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct SpinnerRateView: View {
    @State var show  = false
    @State var name :String = "select".localized
    @State var image : String = ""
    @State var options: [Rate] = [
        Rate(name: "1_star".localized, rate: 1),
        Rate(name: "2_star".localized, rate: 2),
        Rate(name: "3_star".localized, rate: 3),
        Rate(name: "4_star".localized, rate: 4),
        Rate(name: "5_star".localized, rate: 5),
    ]
    var action:(Int) -> Void
    var body: some View {
        VStack{
            HStack{
                Text("\(name)")
                    .foregroundColor(.black)
                    .padding()
                
                Spacer()
                
                Image(systemName: (image == "") ? "chevron.down" : "\(image)")
                    .rotationEffect(.degrees(show ? -180 : 0))
                    .padding()
                
            }
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 1)
                .stroke(lineWidth: 1).fill(Color.theme.greenDark))
            .onTapGesture {
                withAnimation{
                    show.toggle()
                    
                }
            }
            if show {
                ScrollView(showsIndicators: false){
                    VStack(spacing: 16){
                        ForEach(options,id: \.self.rate){ i in
                            Button {
                                withAnimation{
                                    name = i.name
                                    action(i.rate)
                                    show.toggle()
                                }
                            } label: {
                                Text("\(i.name)").padding(.vertical,2).foregroundColor(.black).bold()
                            }
                        }.padding(.horizontal)
                    }
                }.frame(maxWidth: .infinity,maxHeight : 200 ,alignment: .leading)
                    .background(RoundedRectangle(cornerRadius: 1).fill(.white))
            }
        }
    }
}

#Preview {
    SpinnerRateView(){ r in
        
    }
}

struct Rate : Codable {
    let name:String
    let rate:Int
}
