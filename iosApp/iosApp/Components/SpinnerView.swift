//
//  SpinnerView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 7/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct SpinnerView <T: Identifiable> : View {
    @State var show  = false
    @State var name :String = "Select"
    @State var image : String = ""
    @State var options: [T] = []
    var itemToString: (T) -> String
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
                .stroke(lineWidth: 1).fill(Color(hex:"#DBB29D")))
            .onTapGesture {
                withAnimation{
                    show.toggle()
                    
                }
            }
            
            if show {
                ScrollView(showsIndicators: false){
                    VStack(spacing: 16){
                        ForEach(options){ i in
                            Button {
                                withAnimation{
                                    name = itemToString(i)
                                    show.toggle()
                                }
                            } label: {
                                Text("\(itemToString(i))").padding(.vertical,2).foregroundColor(.black)
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
    SpinnerView<Option>(
        options: [
            Option(name: "A"),
            Option(name: "B"),
            Option(name: "C"),
            Option(name: "D"),
            Option(name: "E")
        ],
        itemToString: { $0.name }
    )
}

struct Option: Identifiable, CustomStringConvertible {
    let id = UUID()
    var name: String

    var description: String {
        return name
    }
}
