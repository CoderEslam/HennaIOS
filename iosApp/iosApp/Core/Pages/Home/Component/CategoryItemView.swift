//
//  CategoryItemView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 17/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import ComposeApp

struct CategoryItemView: View {
    var categoryModel : CategoryModel
    var body: some View {
        VStack{
            LoadingImageView(imagePath: Constants().CategoryImages + (categoryModel.category_image ?? ""))
                .frame(width: 100,height: 100)
                .cornerRadius(10)
            Text("\(categoryModel.name ?? "")")
                .multilineTextAlignment(.center)
                .lineLimit(1)
                .frame(maxWidth: 100)
        }
    }
}

#Preview {
    CategoryItemView(categoryModel: CategoryModel(category_image: "", id: 1, name: "", services: [], services_count: 1))
}
