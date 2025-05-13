//
//  ShowLoading.swift
//  iosApp
//
//  Created by Eslam Ghazy on 3/4/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import SwiftUI

struct ShowLoading: ViewModifier {
    @Binding var isLoading: Bool
    func body(content: Content) -> some View {
        ZStack{
            if isLoading {
                content
                ProgressView()
//                    .scaleEffect(2)
//                    .tint(.blue)
            } else {
                content
            }
        }
    }
}

extension View {
    func showLoader(loading: Binding<Bool>) -> some View {
        modifier(ShowLoading(isLoading: loading))
    }
}
