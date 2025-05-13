//
//  InterestItemView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 14/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import ComposeApp

struct InterestItemView: View {
    var categoryModel : CategoryModel
    var body: some View {
        Text("\(categoryModel.name ?? "")")
            .font(.custom(Fonts.montserrat.rawValue, size: 14))
            .foregroundColor(Color.theme.logoPink)
            .padding(.horizontal)
            .padding(.vertical,10)
            .background{
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.theme.logoPink.opacity(0.1))
            }
        
    }
}

//#Preview {
//    InterestItemView()
//}
