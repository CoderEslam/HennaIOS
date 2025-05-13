//
//  ErrorDialogView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 4/4/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import SwiftUI

struct ErrorDialogView: View {
    @StateObject private var userData = SettingsViewModel()
    @State var errorMessage: String = ""
    @State private var showAlert: Bool = false
    @State private var auth : Bool = false
    
    var body: some View {
        ZStack {
            NavigationLink(destination: AuthView(), isActive: $auth) {
                EmptyView()
            }
        }
        .alert("some_error_occur".localized, isPresented: $showAlert) {
            Button("ok".localized, role: .cancel) {
                if errorMessage == "Unauthenticated." {
                    userData.logout()
                    showAlert = false
                    auth = true
                } else {
                    showAlert = false
                }
            }
        } message: {
            Text(errorMessage)
        }
        .onAppear {
            parseErrorMessage()
        }
    }
    
    private func parseErrorMessage() {
        guard let data = errorMessage.data(using: .utf8) else { return }
        
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                if let success = json["success"] as? Bool {
                    print("Success: \(success)")
                }
                if let message = json["errors"] as? String {
                    print("Message: \(message)")
                    errorMessage = message // Update the error message if JSON contains one
                }
                if let message = json["message"] as? String {
                    print("Message: \(message)")
                    errorMessage = message // Update the error message if JSON contains one
                }
            }
        } catch {
            print("JSON parsing error: \(error)")
            errorMessage = "json_decode_error".localized
        }
        
        showAlert = true
    }
}

#Preview {
    ErrorDialogView()
}


extension ErrorDialogView {
    private var goToAuth : some View {
        NavigationLink(destination: AuthView(), isActive: $auth, label: {
            EmptyView()
        })
    }
}
