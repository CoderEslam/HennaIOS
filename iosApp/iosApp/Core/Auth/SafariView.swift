//
//  SafariView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 7/4/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
        // No update required here
    }
}
