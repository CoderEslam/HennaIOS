//
//  LoaingImageView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 13/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import ComposeApp

struct LoadingImageView: View {
    @StateObject private var vm: LoadingImageViewModel
    let imagePath: String

    init(imagePath: String) {
        self.imagePath = imagePath
        _vm = StateObject(wrappedValue: LoadingImageViewModel(imagePath: imagePath))
    }

    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: "\(imagePath)")) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .frame(maxWidth: .infinity,maxHeight: .infinity)
                        //.scaledToFit()
                } else if phase.error != nil {
                    Image("h_logo")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.theme.logoPink)
                } else {
                    LottieView(name: .loading, loopMode: .loop)
                }
            }.frame(maxWidth: .infinity,maxHeight: .infinity)
//            LoadImageView.loadImage(url: imagePath)
//            LoadImageView(image: imagePath)
//            if let image = vm.image {
//                Image(uiImage: image)
//                    .resizable()
//                    //.aspectRatio(contentMode: .fill)
//                    //.cornerRadius(15)
//                    .frame(maxWidth: .infinity,maxHeight: .infinity)
//            } else if vm.isLoading {
//                LottieView(name: .loading, loopMode: .loop)
//            } else {
//                Image(systemName: "questionmark")
//                    .resizable()
//                    .scaledToFit()
//                    .foregroundColor(Color.theme.logoPink)
//            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    LoadingImageView(imagePath: "")
}


struct LoadImageTestView: View {
    private let photoURL = URL(string: "https://picsum.photos/256")

    var body: some View {
        AsyncImage(url: photoURL) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            ProgressView()
        }
    }
}
