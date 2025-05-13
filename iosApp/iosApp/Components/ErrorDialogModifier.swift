//
//  ErrorDialogView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 12/2/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import SwiftUI

struct ErrorDialogModifier: ViewModifier {
    @State private var showAlert: Bool = false
    @State private var errorMessage: String = ""
    @State private var auth: Bool = false
    // Binding to control when the error dialog should be shown
    @Binding var showError: Bool
    var rawErrorMessage: String
    
    func body(content: Content) -> some View {
        content
            .alert("some_error_occur".localized, isPresented: $showAlert) {
                Button("ok".localized, role: .cancel) {
                    if errorMessage == "Unauthenticated." {
                        // Perform logout and navigate to AuthView
                        SettingsViewModel().logout()
                        showAlert = false
                        showError.toggle()
                        auth = true
                    } else {
                        showError.toggle()
                        showAlert = false
                    }
                }
            } message: {
                Text(errorMessage)
            }
            .background(
                NavigationLink(destination: AuthView(), isActive: $auth) {
                    EmptyView()
                }
            )
            .onChange(of: showError) { newValue in
                if newValue {
                    parseErrorMessage()
                }
            }
    }
    
    private func parseErrorMessage() {
        guard let data = rawErrorMessage.data(using: .utf8) else { return }
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


extension View {
    func showErrorDialog(showError: Binding<Bool>, rawErrorMessage: String) -> some View {
        modifier(ErrorDialogModifier(showError: showError, rawErrorMessage: rawErrorMessage))
    }
}


struct ErrorDialogViewExapmle: View {
    var body: some View {
        Text("Hello")
            .showErrorDialog(showError: .constant(true), rawErrorMessage: "Errrrror")
    }
}

#Preview {
    ErrorDialogViewExapmle()
}

