//
//  LoadingImageViewModel.swift
//  iosApp
//
//  Created by Eslam Ghazy on 13/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class LoadingImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false

    private let imagePath: String
    private let dataService: LoadingImageService
    private var cancellables = Set<AnyCancellable>()

    init(imagePath: String) {
        self.imagePath = imagePath
        self.dataService = LoadingImageService()
        fetchImage()
    }

    func fetchImage() {
        isLoading = true
        dataService.loadImage(from: imagePath)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
                self.isLoading = false
            }, receiveValue: { image in
                self.image = image
            })
            .store(in: &cancellables)
    }
}
