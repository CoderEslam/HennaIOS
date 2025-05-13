//
//  CheckBoxView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 18/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import ComposeApp

struct CheckBoxInterestsView: View {
    @StateObject private var mainViewModel = ViewModel()
    @State var isChecked: Bool = false
    var interest : InterestModel
    var interestsList : [InterestsModel] = []
    var body: some View {
        HStack {
            Image(systemName: isChecked ? "checkmark.square" : "square")
                .foregroundColor(isChecked ? Color.theme.logoPink : .gray)
            
            Text("\(interest.name ?? "")")
                .foregroundColor(isChecked ? Color.theme.logoPink : .gray)
                .frame(maxWidth: .infinity, alignment: .leading)
            
        }.onTapGesture {
            withAnimation{
                if isChecked {
                    //delete
                    interestsList.forEach { i in
                        if Int32(truncating: i.category?.id ?? -1) == Int32(truncating: interest.id ?? -1) {
                            mainViewModel.deleteInterest(id: "\(i.id ?? -1)") { response in
                                response.handleState {
                                    print("Loading...")
                                } onSuccess: { response in
                                    print(response)
                                } onError: { errro in
                                    print(errro)
                                }

                            }
                        }
                    }
                } else {
                    //add
                    mainViewModel.setInterest(addInterest: AddInterest(category_id: "\(interest.id ?? -1)")) { response in
                        response.handleState {
                            print("Loading...")
                        } onSuccess: { response in
                            print(response)
                        } onError: { error in
                            print(error)
                        }

                    }
                }
                isChecked.toggle()
            }
        }.onAppear{
            interestsList.forEach { i in
                if Int32(truncating: i.category_id ?? -1) == Int32(truncating: interest.id ?? -1) {
                    isChecked.toggle()
                }
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    CheckBoxInterestsView(interest: InterestModel(category_image: "", id: 1, name: "Hello", user_id: 1))
}
