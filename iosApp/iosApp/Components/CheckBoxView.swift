//
//  CheckBox.swift
//  iosApp
//
//  Created by Eslam Ghazy on 7/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct CheckBoxView: View {
    @Binding var checked: Bool
    @Binding var text :String
    @State private var open:Bool = false
    var body: some View {
        HStack{
            Image(systemName: checked ? "checkmark.square.fill" : "checkmark.square")
                .foregroundColor(checked ? Color("logo_green") : Color("logo_green"))
                
            Text("\(text)")
                .onTapGesture {
                    open.toggle()
                }
        }.fullScreenCover(isPresented: $open, content: {
            SafariView(url: URL(string: "https://hennapp.es/terms")!)
        })
    }
}

#Preview {
    CheckBoxView(checked: .constant(false),text: .constant("check"))
}
