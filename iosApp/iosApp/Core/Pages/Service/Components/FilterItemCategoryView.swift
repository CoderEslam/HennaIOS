//
//  FilterItemCategoryView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 7/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import ComposeApp

struct FilterItemCategoryView: View {
    @Binding var id : Int32
    var categoryModel : CategoryModel
    var action:(_ categoryModel : CategoryModel)->Void
    var body: some View {
        Text("\(categoryModel.name ?? "")")
            .font(.custom(Fonts.montserrat.rawValue, size: 14))
            .foregroundColor(id == Int32(truncating: categoryModel.id ?? -1) ?  Color.white : .black)
            .padding(.horizontal)
            .padding(.vertical,10)
            .background{
                if (id == Int32(truncating: categoryModel.id ?? -1)) {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.theme.logoPink)
                } else {
                    RoundedRectangle(cornerRadius: 25)
                        .stroke()
                        .fill(Color.theme.logoGreen)
                }
            }.onTapGesture {
                action(categoryModel)
            }
        
    }
}

#Preview {
    FilterItemCategoryView(id:.constant(-1), categoryModel: CategoryModel(category_image: "", id: 1, name: "", services: [], services_count: 1)){ categoryModel in
        
    }
}
