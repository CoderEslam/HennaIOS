//
//  AddReviewView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 14/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import ComposeApp

struct AddReviewView: View {
    @StateObject private var mainViewModel = ViewModel()
    @Binding var dissmiss:Bool
    @State private var text : String = ""
    @State private var rate : Int = 0
    @State private var messageResponseState : RequestState<Message> = .idle
    var serviceId : String
    var action:()->Void
    var body: some View {
        VStack(alignment: .leading){
            TopAppBarBackView{
                dissmiss.toggle()
            }
            VStack(alignment: .leading){
                Text("select".localized)
                    .bold()
                SpinnerRateView(){ r in
                    rate = r
                }
                Text("_description".localized)
                    .bold()
                HStack(alignment: .top){
                    TextField("_description".localized, text: $text)
                }.frame(maxWidth: .infinity,alignment: .topLeading)
                    .frame(height: 150)
                    .padding(.horizontal)
                .background{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke()
                        .fill(Color.theme.logoGreen)
                }
                VStack{
                    switch messageResponseState {
                    case .idle:
                        Text("")
                    case .loading:
                        ProgressView()
                    case .success(let data):
                        Text("").onAppear{
                            dissmiss.toggle()
                            action()
                        }
                    case .error(let error):
                        Text("")
                            .showErrorDialog(showError: .constant(true), rawErrorMessage: error)
                    }
                }.frame(maxWidth: .infinity)
                Text("submit_opinion".localized)
                    .foregroundColor(.white)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .background{
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(Color.theme.logoPink)
                    }.onTapGesture {
                        mainViewModel.addReview(postReview: PostReview(service_id: serviceId, rate: Int32(rate), description: text)) { response in
                            messageResponseState = response
                        }
                    }
                
                Spacer()
            }.frame(maxWidth: .infinity,maxHeight: .infinity)
                .padding()
        }
    }
}

#Preview {
    AddReviewView(dissmiss: .constant(false),serviceId: "0"){
        
    }
}
