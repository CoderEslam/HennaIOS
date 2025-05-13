//
//  AddServiceView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 1/12/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import ComposeApp

struct AddServiceView: View {
    @Binding var dismiss : Bool
    var serviceId : Int = -1
    @StateObject private var mainViewModel = ViewModel()
    @StateObject private var userDataViewModel = SettingsViewModel()
    @StateObject private var addNewServiceViewModel = AddNewServiceViewModel()
    @State private var serviceModelDataResponseState : RequestState<ServiceModelData> = .idle
    @State private var categoriesResponseState : RequestState<CategoriesList> = .idle
    @State private var currencyResponseState : RequestState<CurrenciesList> = .idle
    @State private var addServiceResponseState : RequestState<String> = .idle
    @State private var selectedItemCategory : CategoryModel? = nil
    @State private var selectedItemCurrency : CurrencyModel? = nil
    @State private var serviceName :String = ""
    @State private var serviceDes :String = ""
    @State private var priceFrom :String = ""
    @State private var priceTo :String = ""
    @State private var imagesData:[Data] = []
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            VStack{
                TopAppBarBackView {
                    dismiss.toggle()
                }
                VStack(alignment: .leading){
                    Text("service_name".localized)
                        .bold()
                        .padding(.all,4)
                    HStack{
                        Image("pen_edit")
                            .resizable()
                            .frame(width: 20,height: 20)
                            .padding(4)
                        
                        TextField("Service name", text: $serviceName)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                        
                    }.background{
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(lineWidth: 1)
                            .fill(Color.theme.greenDark)
                    }
                }.padding(.vertical,4)
                
                VStack(alignment: .leading){
                    Text("_description".localized)
                        .bold()
                        .padding(.all,4)
                    HStack{
                        Image("pen_des")
                            .resizable()
                            .frame(width: 20,height: 20)
                            .padding(4)
                        
                        TextField("write".localized, text: $serviceDes)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                        
                        
                    }.background{
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(lineWidth: 1)
                            .fill(Color.theme.greenDark)
                    }
                }.padding(.vertical,4)
                
                VStack(alignment: .leading){
                  
                    switch categoriesResponseState {
                    case .idle:
                        Text("").hidden()
                    case .loading:
                        ProgressView()
                    case .success(let data):
                        VStack(alignment: .leading){
                            Text("select_category".localized)
                                .bold()
                                .padding(.all,4)
                            SpinnerViewCompose(
                                items: data.data ?? [],
                                selectedItem: Binding(
                                    get: { selectedItemCategory ?? data.data?.first }, // Default to the first item
                                    set: { selectedItemCategory = $0 }
                                ),
                                onItemSelected: { selectedItemCategory = $0 }) {
                                    $0?.name ?? ""
                                }
                        }
                    case .error(let error):
                        Text("")
                            .showErrorDialog(showError: .constant(true), rawErrorMessage: error)
//                        ErrorDialogView(errorMessage: "\(error)")
                    }
                }.frame(maxWidth: .infinity)
                .padding(.vertical,4)
                
                VStack(alignment: .leading){
                
                    switch currencyResponseState {
                    case .idle:
                        Text("").hidden()
                    case .loading:
                        ProgressView()
                    case .success(let data):
                        VStack(alignment: .leading){
                            Text("select_currency".localized)
                                .bold()
                                .padding(.all,4)
                            SpinnerViewCompose(
                                items: data.data ?? [],
                                selectedItem: Binding(
                                    get: { selectedItemCurrency ?? data.data?.first }, // Default to the first item
                                    set: { selectedItemCurrency = $0 }
                                ),
                                onItemSelected: { selectedItemCurrency = $0 }) {
                                    $0?.name ?? ""
                                }
                        }
                    case .error(let error):
                        Text("")
                            .showErrorDialog(showError: .constant(true), rawErrorMessage: error)
                    }
                }.frame(maxWidth: .infinity)
                    .padding(.vertical,4)
                
                VStack(alignment: .leading){
                    Text("price".localized)
                        .bold()
                        .padding(.all,4)
                    HStack{
                        HStack{
                            Text("from".localized)
                                .padding(.horizontal)
                            TextField("from".localized, text: $priceFrom)
                            
                        }.frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background{
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(lineWidth: 1)
                                    .fill(Color.theme.greenDark)
                            }
                        
                        HStack{
                            Text("to".localized)
                                .padding(.horizontal)
                            TextField("to".localized, text: $priceTo)
                            
                        }.frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background{
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(lineWidth: 1)
                                    .fill(Color.theme.greenDark)
                            }
                    }
                }.padding(.vertical,4)
                
                ZStack{
                    SelectMultipleImagesView(){ images in
                        self.imagesData = images
                        print("IMAGESSS \(images)")
                    }
                }.frame(height : 200).padding()
                    .background{
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.white)
                            .shadow(color: .gray.opacity(0.5) ,radius: 4)
                    }
                
                switch addServiceResponseState {
                case .idle:
                    Text("").hidden()
                case .loading:
                    ProgressView()
                case .success(let data):
                    Text("\(data)")
                case .error(let error):
                    Text("")
                        .showErrorDialog(showError: .constant(true), rawErrorMessage: error)
                }
                
                Text("upload".localized)
                    .bold()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height : 50)
                    .background{
                       RoundedRectangle(cornerRadius: 50)
                            .fill(Color.theme.logoPink)
                    }.onTapGesture {
                        if serviceId != -1 {
                            editService()
                        } else {
                            addNewService()
                        }
                    }
            }.onAppear{
                mainViewModel.categoryList { response in
                    categoriesResponseState = response
                }
                mainViewModel.getCurrency { response in
                    currencyResponseState = response
                }
                showService()
            }.frame(maxWidth: .infinity)
                .frame(maxHeight: .infinity)
                .padding()
                
        }.frame(maxWidth: .infinity)
            .frame(maxHeight: .infinity)
    }
    
    private func showService(){
        if serviceId != -1 {
            mainViewModel.showServiceById(id: serviceId){ response in
                serviceModelDataResponseState = response
                response.handleState {
                    
                } onSuccess: { data in
                    print("\(data)")
                    serviceName = data.data.name ?? ""
                    serviceDes = data.data.description_ ?? ""
                    priceFrom = "\(data.data.min_price ?? 0)"
                    priceTo = "\(data.data.max_price ?? 0)"
                    selectedItemCategory = CategoryModel(
                        category_image: "\(data.data.category?.category_image ?? "")",
                        id: data.data.category?.id ,
                        name: "\(data.data.category?.name ?? "")",
                        services: nil,
                        services_count: nil
                    )
                    selectedItemCurrency = CurrencyModel(
                        id: data.data.currency?.id,
                        name: data.data.currency?.name,
                        user_id: data.data.currency?.user_id
                    )
                } onError: { error in
                    
                }
            }
        }
    }
    
    private func addNewService(){
        addNewServiceViewModel.uploadNewService(
            name: serviceName,
            description: serviceDes,
            maxPrice: priceTo,
            minPrice: priceFrom,
            categoryId: "\(selectedItemCategory?.id ?? -1)",
            providerId: "\(userDataViewModel.getProviderId())",
            currencyId: "\(selectedItemCurrency?.id ?? -1)",
            imagesData: imagesData
        ) { p in
            print("NEW SERVICE \(p)")
        } completion: { response in
            addServiceResponseState = response
            response.handleState {
                print("NEW SERVICE Loading")
            } onSuccess: { data in
                print("NEW SERVICE \(data)")
            } onError: { error in
                print("NEW SERVICE \(error)")
            }
        }
    }
    
    private func editService(){
        addNewServiceViewModel.updateService(
            idService: "\(serviceId)",
            name: serviceName,
            description: serviceDes,
            maxPrice: priceTo,
            minPrice: priceFrom,
            categoryId: "\(selectedItemCategory?.id ?? -1)",
            providerId: "\(userDataViewModel.getProviderId())",
            currencyId: "\(selectedItemCurrency?.id ?? -1)",
            imagesData: imagesData
        ) { p in
            print("EDIT SERVICE \(p)")
        } completion: { response in
            response.handleState {
                print("EDIT SERVICE Loading")
            } onSuccess: { data in
                print("EDIT SERVICE \(data)")
            } onError: { error in
                print("EDIT SERVICE \(error)")
            }
        }
        
    }
}

#Preview {
    AddServiceView(dismiss: .constant(false))
}
