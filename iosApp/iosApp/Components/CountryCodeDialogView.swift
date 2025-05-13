//
//  CountryCodeDialogView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 16/2/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import SwiftUI

struct CountryCodeDialogView: View {
//    @ObservedObject private var countryCodeViewModel = CountryCodeViewModel()
//    @Binding var selectedOldCode : String
//    @State private var selectedCode: String = ""
//    @State private var countryCodeData: [CountryData] = []
//    
//    var action: (CountryData) -> Void  // Function to send selected country
//    
//    var body: some View {
//        VStack {
//            Picker("Select code", selection: $selectedCode) {
//                ForEach(countryCodeData, id: \.dial_code) { country in
//                    Text("\(country.name) \(country.flag) \(country.dial_code)")
//                        .tag(country.dial_code) // Ensure correct selection
//                }
//            }
//            .pickerStyle(MenuPickerStyle()) // Optional styling
//            .onChange(of: selectedCode) { newValue in
//                if let selectedCountry = countryCodeData.first(where: { $0.dial_code == newValue }) {
//                    //action(selectedCountry)  // Call the action function
//                }
//            }
//        }
//        .onAppear {
//            countryCodeData.forEach { countryData in
//                if countryData.dial_code == selectedOldCode {
//                    self.selectedCode = "\(countryData.name) \(countryData.flag) \(countryData.dial_code)"
//                    action(countryData)
//                }
//            }
//            countryCodeViewModel.loadData { codes in
//                self.countryCodeData = codes
//                if let firstCode = codes.first?.dial_code {
//                    self.selectedCode = firstCode // Default selection
//                }
//            }
//        }
//    }
    @ObservedObject private var countryCodeViewModel = CountryCodeViewModel()
    @Binding var selectedOldCode: String  // Binding for old selection
    @State private var selectedCode: String = ""
    @State private var countryCodeData: [CountryData] = []
    
    var action: (CountryData) -> Void  // Function to send selected country
    
    var body: some View {
        VStack {
            Picker("Select code", selection: $selectedCode) {
                ForEach(countryCodeData, id: \.dial_code) { country in
                    Text("\(country.name) \(country.flag) \(country.dial_code)")
                        .tag(country.dial_code) // Ensure correct selection
                }
            }
            .pickerStyle(MenuPickerStyle()) // Optional styling
            .onChange(of: selectedCode) { newValue in
                if let selectedCountry = countryCodeData.first(where: { $0.dial_code == newValue }) {
                    action(selectedCountry)  // Call the action function
                }
            }
        }
        .onAppear {
            countryCodeViewModel.loadData { codes in
                self.countryCodeData = codes
                
                // Select old code if it exists; otherwise, select first item
                if let existingCode = codes.first(where: { $0.dial_code == selectedOldCode }) {
                    self.selectedCode = existingCode.dial_code
                } else if let firstCode = codes.first?.dial_code {
                    self.selectedCode = firstCode
                }
                
                // Call action with the selected country
                if let selectedCountry = codes.first(where: { $0.dial_code == self.selectedCode }) {
                    action(selectedCountry)
                }
            }
        }
    }
}

#Preview {
    CountryCodeDialogView(selectedOldCode: .constant("")) { c in
        
    }
}
