//
//  CountryCodeViewModel.swift
//  iosApp
//
//  Created by Eslam Ghazy on 16/2/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation

class CountryCodeViewModel: ObservableObject {
    
    @Published var codeCountry = [CountryData]()
    
    
    func loadData(completion: @escaping ([CountryData]) -> Void) {
        guard let countryCodeData = Bundle.main.url(forResource: "countryCode", withExtension: "json") else {
            print("countryCode.json file not found")
            return
        }
        
        do {
            let data = try Data(contentsOf: countryCodeData)
            let code = try JSONDecoder().decode([CountryData].self, from: data)
            DispatchQueue.main.async {
                self.codeCountry = code
                completion(self.codeCountry)
            }
        } catch {
            print("Failed to decode JSON:", error)
        }
    }
}
