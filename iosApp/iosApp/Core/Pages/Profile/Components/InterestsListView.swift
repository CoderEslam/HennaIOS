//
//  InterestsListView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 18/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import ComposeApp

struct InterestsListView: View {
    @StateObject private var mainViewModel = ViewModel()
    @State private var interestsResponseState : RequestState<InterestsList> = .idle
    @State private var messageResponseState : RequestState<Message> = .idle
    @Binding var showIntersts:Bool
    var interestsList : [InterestsModel] = []
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            VStack{
                switch interestsResponseState {
                case .idle:
                    Text("").hidden()
                case .loading:
                    ProgressView()
                case .success(let data):
                    TopAppBarBackView {
                        showIntersts.toggle()
                    }
                    LazyVStack(content: {
                        ForEach(data.data ?? [], id: \.self.id) { interest in
                            CheckBoxInterestsView(interest: interest, interestsList:interestsList)
                        }
                    }).padding(.horizontal)
                case .error(let error):
                    Text("\(error)")
                }
            }
        }.onAppear{
            mainViewModel.getInterestsList { response in
                interestsResponseState = response
            }
        }
    }
}

#Preview {
    InterestsListView(showIntersts : .constant(false),interestsList: [InterestsModel(category: CategoryModel(category_image: "", id: 1, name: "H", services: nil, services_count: 1), category_id: 1, id: 1, user_id: 1),InterestsModel(category: CategoryModel(category_image: "", id: 1, name: "E", services: nil, services_count: 1), category_id: 1, id: 1, user_id: 1)])
}
