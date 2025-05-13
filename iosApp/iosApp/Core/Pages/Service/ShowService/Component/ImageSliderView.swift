//
//  ImageSliderView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 14/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import ComposeApp

//struct ImageSliderView: View {
//    var images: [String] = []
//    var body: some View {
//        TabView {
//            ForEach(images,id: \.self) { item in
//                LoadingImageView(imagePath: Constants().ServiceImages + item)
//                    .scaledToFill()
//            }
//        }
//        .tabViewStyle(PageTabViewStyle())
//    }
//}

struct ImageSliderView: View {
    var images: [String] = ["1711892374ML Fotografos_0.png","1711892374ML Fotografos_1.png","1711892374ML Fotografos_2.png","1711892374ML Fotografos_3.png"]
    @State private var currentIndex = 0
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect() // Adjust interval as needed

    var body: some View {
        VStack{
            TabView(selection: $currentIndex) {
                ForEach(Array(images.enumerated()), id: \.1) { index, item in
                    LoadingImageView(imagePath: Constants().ServiceImages + item)
                        .scaledToFill()
                        .tag(index) // Tag each page with its index
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .onReceive(timer) { _ in
                withAnimation {
                    currentIndex = (currentIndex + 1) % images.count // Loop back to first image after the last
                }
            }
            .onDisappear {
                timer.upstream.connect().cancel() // Stop the timer when the view disappears
            }
        }.cornerRadius(25)
    }
}

#Preview {
    ImageSliderView()
}
