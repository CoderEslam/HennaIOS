//
//  SpinnerViewCompose.swift
//  iosApp
//
//  Created by Eslam Ghazy on 30/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct SpinnerViewCompose<T: Hashable>: View {
    let items: [T]
    @Binding var selectedItem: T
    var onItemSelected: (T) -> Void
    var itemToString: (T) -> String = { "\($0)" } // Default toString conversion

    @State private var isExpanded = false

    var body: some View {
        VStack {
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Text(itemToString(selectedItem))
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName:"chevron.down")
                        .rotationEffect(isExpanded ? .degrees(180) : .degrees(0))
                        .foregroundColor(.black)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
            }
            
            if isExpanded {
                VStack(spacing: 0) {
                    ForEach(items, id: \.self) { item in
                        Button(action: {
                            selectedItem = item
                            onItemSelected(item)
                            withAnimation {
                                isExpanded = false
                            }
                        }) {
                            Text(itemToString(item))
                                .foregroundColor(.black)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .background(Color.white)
                        .overlay(
                            Rectangle()
                                .fill(Color.gray)
                                .frame(height: 1),
                            alignment: .bottom
                        )
                    }
                }
                .background(Color.white)
                .cornerRadius(8)
                .shadow(color: Color.gray.opacity(0.5), radius: 8, x: 0, y: 2)
            }
        }
    }
}

#Preview {
    SpinnerViewCompose(
        items: ["Option 1", "Option 2", "Option 3"],
        selectedItem: .constant("Option 1"),
        onItemSelected: { item in
            print("Selected item: \(item)")
        }
    )
}
