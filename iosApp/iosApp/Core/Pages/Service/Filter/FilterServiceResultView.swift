//
//  FilterServiceResultView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 6/12/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import ComposeApp

struct FilterServiceResultView: View {
    @State private var showService: Bool = false
    @State private var serviceId:Int = -1
    @Binding var filterList:FilterList?
    @Binding var dismiss : Bool
    private let gridItems:[GridItem] = [
        .init(.flexible(),spacing: 1),
        .init(.flexible(),spacing: 1)
    ]
    var body: some View {
        VStack{
            TopAppBarBackView {
                dismiss.toggle()
            }
            ScrollView(.vertical,showsIndicators: false){
                if (filterList?.data ?? [] ).isEmpty {
                    Text("Empty data")
                } else {
                    LazyVGrid(columns: gridItems ,spacing: 1){
                        ForEach(filterList?.data ?? [] ,id: \.self.id){ service  in
                            ServiceItemView(service: service){service in
                                serviceId = Int(truncating: service.id ?? 0)
                                showService.toggle()
                            }.padding(.top,5)
                        }
                    }
                }
            }
        }.fullScreenCover(isPresented: $showService, content: {
            ShowServiceView(dismiss : $showService, id: $serviceId)
        })
    }
}

#Preview {
    FilterServiceResultView(filterList: .constant(nil), dismiss: .constant(false))
}
