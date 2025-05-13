//
//  SplashView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 7/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import Combine


struct SplashView: View {
    @StateObject private var userDate = SettingsViewModel()
    @State private var pageIndex = 0
    @State private var home : Bool = false
    private let pages: [PageModel] = PageModel.pages
    private let dotAppearance = UIPageControl.appearance()
    
    // Timer to control auto-scrolling
    private let autoScrollInterval = 3.0 // Set the interval in seconds
    @State private var timer: AnyCancellable?
    
    var body: some View {
        NavigationView {
            VStack{
                if userDate.token.isNotEmpty {
                    goToHome.onAppear{
                        home = true
                    }
                } else {
                    ZStack {
                        TabView(selection: $pageIndex) {
                            ForEach(pages) { page in
                                VStack {
                                    PageView(page: page)
                                }
                                .tag(page.tag)
                            }
                        }
                        .tabViewStyle(.page)
                        .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                        .onAppear {
                            dotAppearance.currentPageIndicatorTintColor = .white
                            startAutoScroll()
                        }
                        .onDisappear {
                            stopAutoScroll()
                        }
                    }.ignoresSafeArea()
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    // Function to increment the pageIndex
    func incrementPage() {
        pageIndex = (pageIndex + 1) % pages.count
    }
    
    // Starts the timer for auto-scrolling
    private func startAutoScroll() {
        timer = Timer.publish(every: autoScrollInterval, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                incrementPage()
            }
    }
    
    // Stops the timer when the view disappears
    private func stopAutoScroll() {
        timer?.cancel()
    }
}

#Preview {
    SplashView()
}


extension SplashView {
    
    private var goToHome : some View {
        NavigationLink(destination: HomeView(), isActive: $home, label: {
            EmptyView()
        })
    }
    
}
