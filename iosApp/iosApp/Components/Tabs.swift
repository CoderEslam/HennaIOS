//
//  Tabs.swift
//  HennaApp
//
//  Created by Eslam Ghazy on 20/9/23.
//

import SwiftUI

//https://johncodeos.com/how-to-create-tabs-with-swiftui/
struct Tab {
    var icon: Image?
    var title: String
}

struct Tabs: View {
    var fixed = true
    var tabs: [Tab]
    var geoWidth: CGFloat
    @Binding var selectedTab: Int

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { proxy in
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        ForEach(0 ..< tabs.count, id: \.self) { row in
                            Button(action: {
                                withAnimation {
                                    selectedTab = row
                                }
                            }, label: {
                                VStack(spacing: 0) {
                                    HStack {
                                        // Image
                                        AnyView(tabs[row].icon)
                                            .foregroundColor(Color(hex: "#AFC9C0"))
                                            .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))

                                        // Text
                                        Text(tabs[row].title)
                                            .font(Font.system(size: 18, weight: .semibold))
                                            .foregroundColor(Color(hex: "#070A13"))
                                            .padding(EdgeInsets(top: 10, leading: 3, bottom: 10, trailing: 15))
                                    }
                                    .frame(width: fixed ? (geoWidth / CGFloat(tabs.count)) : .none, height: 52)
                                    // Bar Indicator
                                    
                                    Rectangle().fill(selectedTab == row ? Color(hex: "#AFC9C0") : Color.clear)
                                        .frame(height: 3)
                                }.fixedSize()
                            })
                                .accentColor(Color.white)
                                .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .onChange(of: selectedTab) { target in
                        withAnimation {
                            proxy.scrollTo(target)
                        }
                    }
                }
            }
        }
        .frame(height: 55)
        .onAppear(perform: {
//            UIScrollView.appearance().backgroundColor = UIColor(#colorLiteral(red: Float(69) / 255.0, green: Float(184) / 255.0, blue: Float(235) / 255.0, alpha: 1))
            UIScrollView.appearance().bounces = fixed ? false : true
        })
        .onDisappear(perform: {
            UIScrollView.appearance().bounces = true
        })
    }
}

struct Tabs_Previews: PreviewProvider {
    static var previews: some View {
        Tabs(fixed: true,
             tabs: [.init(icon: Image(systemName: "star.fill"), title: "Tab 1"),
                    .init(icon: Image(systemName: "star.fill"), title: "Tab 2"),
                    .init(icon: Image(systemName: "star.fill"), title: "Tab 3")],
             geoWidth: 375,
             selectedTab: .constant(0))
    }
}

