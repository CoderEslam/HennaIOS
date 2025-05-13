//
//  CommentViewModel.swift
//  iosApp
//
//  Created by Eslam Ghazy on 3/4/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import ComposeApp

class CommentViewModel : ObservableObject {
    
    private let mainViewModel: ViewModel = ViewModel()
    @Published var state = CommentState()
    
    func onEvent(_ event:CommentEvent){
        switch event {
        case .setComment(let id):
            setComment(id)
        }
    }
    
    func showUser(){
        mainViewModel.showUser { response in
            response.handleState {
                self.state.isLoading = true
                self.state.showError = false
                self.state.error = ""
            } onSuccess: { userModel in
                self.state.isLoading = false
                self.state.showError = false
                self.state.error = ""
                self.state.userModel = userModel
            } onError: { error in
                self.state.isLoading = false
                self.state.showError = true
                self.state.error = error
            }
        }
    }
    
    func getCommentPostById(_ id:Int32){
        mainViewModel.getCommentPostById(id: id) { response in
            response.handleState {
                self.state.isLoading = true
                self.state.showError = false
                self.state.error = ""
            } onSuccess: { commentsList in
                self.state.isLoading = true
                self.state.showError = false
                self.state.error = ""
                self.state.commentsList = commentsList
            } onError: { error in
                self.state.isLoading = false
                self.state.showError = true
                self.state.error = error
            }
        }
    }
    
    func setComment(_ id:Int32){
        mainViewModel.setComment(comment: Comment(post_id: id, content: self.state.comment)) { response in
            response.handleState {
                self.state.isLoading = true
                self.state.showError = false
                self.state.error = ""
            } onSuccess: { message in
                self.state.isLoading = false
                self.state.showError = false
                self.state.error = ""
                self.getCommentPostById(id)
            } onError: { error in
                self.state.isLoading = false
                self.state.showError = true
                self.state.error = error
            }
            self.state.comment = ""
        }
    }
    
}
