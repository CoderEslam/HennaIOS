//
//  AddPostView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 3/12/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import ComposeApp

struct AddPostView: View {
    @StateObject private var addNewPostViewModel = AddNewPostViewModel()
//    @State private var text : String = ""
    @State private var selectImageOrVideo : Bool = false
//    @State private var contentType : ContentType = .TEXT
//    @State private var contentData : Data? = nil
    @Binding var dismiss : Bool
    var body: some View {
        VStack{
            HStack{
                HStack{
                    Image(systemName: "chevron.left")
                    Text("back".localized)
                }.bold()
                    .foregroundColor(.black)
                    .onTapGesture {
                        withAnimation{
                            dismiss.toggle()
                        }
                    }
                Spacer()
                Text("create_post".localized)
                Spacer()
                Text("Post").foregroundColor(.white)
                    .padding(8)
                    .padding(.horizontal,16)
                    .background{
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.theme.logoPink)
                    }
                    .onTapGesture {
                        addNewPostViewModel.uploadNewPost() { p in
                            print("\(p)")
                        } completion: { response in
                            response.handleState {
                                print("POST Loading...")
                            } onSuccess: { response in
                                print("POST \(response)")
                            } onError: { error in
                                print("POST \(error)")
                            }
                        }
                    }
            }.padding()
            
            HStack{
                LoadingImageView(imagePath: Constants().UsersImages + (addNewPostViewModel.state.userModel?.data?.user_image ?? ""))
                    .frame(width: 25,height: 25)
                    .clipShape(Circle())
                    .padding(8)
                Text("\(addNewPostViewModel.state.userModel?.data?.first_name ?? "") \(addNewPostViewModel.state.userModel?.data?.last_name ?? "")")
                Spacer()
            }.padding(.vertical,4)
            
            TextField("what_are_you_thinking".localized, text: $addNewPostViewModel.state.description)
            
            Spacer()
            HStack{
                Spacer()
                PhotoOrVideoPickerView(){ data , type in
                    if type == "image" {
                        addNewPostViewModel.onEvent(.data(data))
                        addNewPostViewModel.onEvent(.type(.IMAGE))
                        print("User selected an image.")
                    } else if type == "video" {
                        addNewPostViewModel.onEvent(.data(data))
                        addNewPostViewModel.onEvent(.type(.VIDEO))
                        print("User selected a video.")
                    } else {
                        addNewPostViewModel.onEvent(.data(nil))
                        addNewPostViewModel.onEvent(.type(.TEXT))
                        print("Unknown type selected.")
                    }
                }
            }
        }
        .showLoader(loading: $addNewPostViewModel.state.isLoading)
        .showErrorDialog(showError: $addNewPostViewModel.state.showError, rawErrorMessage: addNewPostViewModel.state.error)
        .padding()
        .onAppear{
            addNewPostViewModel.showUser()
        }
    }
}

#Preview {
    AddPostView(dismiss: .constant(false))
}

enum ContentType : String {
    case TEXT = "1"
    case IMAGE = "2"
    case VIDEO = "3"
}
