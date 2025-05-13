//
//  ViewMoreTextView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 16/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct ViewMoreTextView: View {
    let text: String
    var ellipsizedText: String = "View More"
    var visibleLines: Int = 3
    var animationDuration: Double = 0.3
    var ellipsizedTextColor: Color = .blue
    var isUnderlined: Bool = false
    
    @State private var isExpanded: Bool = false
    @State private var truncated: Bool = true
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(isExpanded ? text : truncatedText)
                .lineLimit(isExpanded ? nil : visibleLines)
                .animation(.easeInOut(duration: animationDuration), value: isExpanded)
                .background(
                    Text(text)
                        .lineLimit(visibleLines)
                        .background(GeometryReader { visibleTextGeometry in
                            Color.clear.onAppear {
                                truncated = textFits(visibleTextGeometry: visibleTextGeometry)
                            }
                        })
                        .hidden()
                )
                .foregroundColor(.primary)
            
            if truncated {
                Button(action: {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }) {
                    Text(isExpanded ? "view_less".localized : ellipsizedText)
                        .foregroundColor(ellipsizedTextColor)
                        .underline(isUnderlined, color: ellipsizedTextColor)
                }
            }
        }.frame(maxWidth: .infinity,maxHeight: .infinity)
    }
    
    private var truncatedText: String {
        guard let visibleIndex = visibleTextEndIndex else { return text }
        return String(text[..<visibleIndex])
    }
    
    private var visibleTextEndIndex: String.Index? {
        guard !isExpanded, visibleLines > 0 else { return nil }
        return text.index(text.startIndex, offsetBy: min(visibleLines, text.count))
    }
    
    private func textFits(visibleTextGeometry: GeometryProxy) -> Bool {
        let visibleHeight = visibleTextGeometry.size.height
        var fullHeight: CGFloat = 0
        Text(text)
            .lineLimit(nil) // Ensure the full text is rendered for measurement
            .fixedSize(horizontal: false, vertical: true) // Prevent horizontal wrapping
            .frame(maxWidth: visibleTextGeometry.size.width) // Match the width of the visible text
            .background(
                GeometryReader { fullTextGeometry in
                    Color.clear
                        .onAppear {
                            fullHeight = fullTextGeometry.size.height
                        }
                }
            )
        return visibleHeight >= fullHeight
    }
}

#Preview {
    ViewMoreTextView(
        text: "This is a long text example to demonstrate the ViewMoreTextView implementation in SwiftUI. It supports toggling between expanded and collapsed states.",
        visibleLines: 50,
        ellipsizedTextColor: .blue,
        isUnderlined: true
    )
}
