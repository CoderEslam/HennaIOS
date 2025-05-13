//
//  AddNewServiceViewModel.swift
//  iosApp
//
//  Created by Eslam Ghazy on 3/12/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation

class AddNewServiceViewModel : ObservableObject {
    
    private let newService = AddNewService()
    
    func uploadNewService(
        name: String,
        description: String,
        maxPrice: String,
        minPrice: String,
        categoryId: String,
        providerId: String,
        currencyId: String,
        imagesData: [Data]?,
        progressHandler: @escaping (Double) -> Void,
        completion: @escaping (RequestState<String>) -> Void
    ) {
        newService.uploadNewService(
            name: name,
            description: description,
            maxPrice: maxPrice,
            minPrice: minPrice,
            categoryId: categoryId,
            providerId: providerId,
            currencyId: currencyId,
            imagesData: imagesData
        ) { p in
            progressHandler(p)
        } completion: { response in
            completion(response)
        }
    }
    
    func updateService(
        idService: String,
        name: String,
        description: String,
        maxPrice: String,
        minPrice: String,
        categoryId: String,
        providerId: String,
        currencyId: String,
        imagesData: [Data]?,
        progressHandler: @escaping (Double) -> Void,
        completion: @escaping (RequestState<String>) -> Void
    ) {
        newService.updateService(
            idService: idService,
            name: name,
            description: description,
            maxPrice: maxPrice,
            minPrice: minPrice,
            categoryId: categoryId,
            providerId: providerId,
            currencyId: currencyId,
            imagesData: imagesData) { p in
                progressHandler(p)
            } completion: { response in
                completion(response)
            }
    }
    
}
