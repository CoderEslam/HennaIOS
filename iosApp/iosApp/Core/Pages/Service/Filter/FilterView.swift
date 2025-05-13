//
//  FilterView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 5/12/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import ComposeApp

struct FilterView: View {
    @StateObject private var filterViewModel = FilterViewModel()
    @Binding var dismiss : Bool
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            VStack{
                TopAppBarBackView {
                    dismiss.toggle()
                }
                
                SpinnerViewCompose(
                    items: filterViewModel.state.categoryList?.data ?? [],
                    selectedItem: Binding(
                        get: { filterViewModel.state.selectedItemCategory ?? filterViewModel.state.categoryList?.data?.first },
                        set: { filterViewModel.state.selectedItemCategory = $0 }
                    ),
                    onItemSelected: { filterViewModel.state.selectedItemCategory = $0 }) {
                        $0?.name ?? ""
                    }
                
                SpinnerViewCompose(
                    items: filterViewModel.state.countryList?.data ?? [],
                    selectedItem: Binding(
                        get: { filterViewModel.state.selectedItemCountry ?? filterViewModel.state.countryList?.data?.first },
                        set: { filterViewModel.state.selectedItemCountry = $0 }
                    ),
                    onItemSelected: { filterViewModel.state.selectedItemCountry = $0 }) {
                        $0?.name ?? ""
                    }
                
                SpinnerViewCompose(
                    items: filterViewModel.state.selectedItemCountry?.provinces ?? [],
                    selectedItem: Binding(
                        get: { filterViewModel.state.selectedItemProvince ?? filterViewModel.state.selectedItemCountry?.provinces?.first },
                        set: { filterViewModel.state.selectedItemProvince = $0 }
                    ),
                    onItemSelected: { filterViewModel.state.selectedItemProvince = $0 }) {
                        $0?.name ?? ""
                    }
                
                SpinnerViewCompose(
                    items: filterViewModel.state.selectedItemProvince?.cities ?? [],
                    selectedItem: Binding(
                        get: { filterViewModel.state.selectedItemCity ?? filterViewModel.state.selectedItemProvince?.cities?.first },
                        set: { filterViewModel.state.selectedItemCity = $0 }
                    ),
                    onItemSelected: { filterViewModel.state.selectedItemCity = $0 }) {
                        $0?.name ?? ""
                    }
                
                SpinnerViewCompose(
                    items: filterViewModel.state.currencyList?.data ?? [],
                    selectedItem: Binding(
                        get: { filterViewModel.state.selectedItemCurrency ?? filterViewModel.state.currencyList?.data?.first },
                        set: { filterViewModel.state.selectedItemCurrency = $0 }
                    ),
                    onItemSelected: { filterViewModel.state.selectedItemCurrency = $0 }) {
                        $0?.name ?? ""
                    }
                
                RangeSliderView(){ r in
                    print("RANGE ->  \(r)")
                }
                Spacer()
                
                Text("show_results".localized)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background{
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.theme.logoPink)
                    }.onTapGesture{
                        filterViewModel.filter()
                    }
            }
            .padding()
            .fullScreenCover(isPresented: $filterViewModel.state.showFilterResult, content: {
                FilterServiceResultView(filterList: $filterViewModel.state.filterList, dismiss: $filterViewModel.state.showFilterResult)
            })
            .showLoader(loading: $filterViewModel.state.isLoading)
            .showErrorDialog(showError: $filterViewModel.state.showError, rawErrorMessage: filterViewModel.state.error)
            .onAppear{
                filterViewModel.getCategories()
                filterViewModel.getCurrency()
                filterViewModel.getCountries()
            }
        }
        
    }
}

#Preview {
    FilterView(dismiss: .constant(false))
}
