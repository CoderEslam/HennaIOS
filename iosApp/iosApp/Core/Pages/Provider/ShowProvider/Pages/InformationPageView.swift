//
//  InformationPageView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 16/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import ComposeApp

struct InformationPageView: View {
    var data: ProviderModel_
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                HStack{
                    Image("location")
                    Text("\(data.user?.country?.name ?? ""), ")
                    +
                    Text("\(data.user?.province?.name ?? ""), ")
                    +
                    Text("\(data.user?.city?.name ?? "")")
                }
                
                HStack{
                    Image("category")
                    Text("\(data.services?.count ?? 0) ")
                    +
                    Text("categories".localized)
                }
                HStack{
                    Image("about")
                    Text("\(data.provider_bio ?? "")")
                }
            }
        }
    }
}

#Preview {
    InformationPageView(data: ProviderModel_(brand_name: "", id: 1, provider_bio: "", services: nil, user: nil, user_id: 1))
}
