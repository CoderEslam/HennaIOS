//
//  RatingView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 7/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct RatingView: View {
    @Binding var selected : Int
    @State var width :CGFloat = 10
    @State var height :CGFloat = 10
    var body: some View {
        VStack{
            HStack(spacing: 6){
                ForEach(1..<6){i in
                    Image(systemName: "star.fill")
                        .resizable()
                        .foregroundColor(self.selected >= i ? Color(hex: "#FAD11A") : Color(hex: "#D9D4D4"))
                        .frame(width: width,height: height)
                        .onTapGesture {
                            self.selected = i
                        }
                }
            }
        }
    }
}

#Preview {
    RatingView(selected: .constant(0))
}
