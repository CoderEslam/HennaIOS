//
//  RequestState.swift
//  iosApp
//
//  Created by Eslam Ghazy on 7/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation
import SwiftUI

enum RequestState<T> {
    case idle
    case loading
    case success(T)
    case error(String)
    
    // Helper methods
    var isLoading: Bool {
        if case .loading = self { return true }
        return false
    }
    
    var isSuccess: Bool {
        if case .success = self { return true }
        return false
    }
    
    var isError: Bool {
        if case .error = self { return true }
        return false
    }
    
    // Extract data from success
    func getSuccessData() -> T? {
        if case .success(let data) = self {
            return data
        }
        return nil
    }
    
    // Extract error message
    func getErrorMessage() -> String? {
        if case .error(let message) = self {
            return message
        }
        return nil
    }
    
    // Display the different states
    func displayResult(
        onIdle: (() -> AnyView)? = nil,
        onLoading: () -> AnyView,
        onSuccess: (T) -> AnyView,
        onError: (String) -> AnyView
    ) -> AnyView {
        switch self {
        case .idle:
            return onIdle?() ?? AnyView(EmptyView())
        case .loading:
            return onLoading()
        case .success(let data):
            return onSuccess(data)
        case .error(let message):
            return onError(message)
        }
    }
    
    func handleState(
        onIdle: (() -> Void)? = nil,
        onLoading: () -> Void,
        onSuccess: (T) -> Void,
        onError: (String) -> Void
    ) {
        switch self {
        case .idle:
            onIdle?()
        case .loading:
            onLoading()
        case .success(let data):
            onSuccess(data)
        case .error(let message):
            onError(message)
        }
    }
}
