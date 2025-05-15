//
//  ReviewItemView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 14/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import ComposeApp

struct ReviewItemView : View {
    @StateObject private var mainViewModel = ViewModel()
    @State private var messageResponseState : RequestState<Message> = .idle
    var review: Review
    var userId : Int
    var action:() -> Void
    var body: some View {
        HStack{
            LoadingImageView(imagePath: Constants().UsersImages + "\(review.user?.user_image ?? "")")
                .frame(width: 80,height: 80)
                .cornerRadius(50)
            VStack(alignment: .leading){
                Text("\(review.user?.first_name ?? "") \(review.user?.last_name ?? "")")
                    .bold()
                Text("\(review.description_ ?? "")")
            }.frame(maxWidth: .infinity)
            Spacer()
            switch messageResponseState {
            case .idle:
                Text("").hidden()
            case .loading:
                ProgressView()
            case .success(let data):
                Text("\(data)").onAppear{
                    action()
                }.hidden()
            case .error(let error):
                ErrorDialogView(errorMessage: error)
            }
            RatingView(selected: .constant(Int(truncating: review.rate ?? 0)))
            if review.user?.id ==  Int32(userId) {
                Menu {
                    Button("delete".localized, action: deleteReview)
                } label: {
                    Label("", systemImage: "ellipsis")
                        .foregroundColor(.black)
                        .rotationEffect(.degrees(90))
                        .padding()
                        .bold()
                }
            }
        }
    }
    
    func deleteReview() {
        mainViewModel.deleteReview(id: Int(truncating: review.id ?? 0)) { response in
            messageResponseState = response
        }
    }
}

#Preview {
    ReviewItemView(review: Review(description: "", id: 1, rate: 2, service: nil, service_id: 1, user: nil, user_id: 1), userId: 0){
        
    }
}
