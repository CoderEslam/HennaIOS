//
//  LottieViewAddToCart.swift
//  resturant
//
//  Created by Eslam Ghazy on 10/9/24.
//

import SwiftUI
import Lottie

struct LottieView : UIViewRepresentable {
    var name: LottieFiles = .loading
    var loopMode: LottieLoopMode = .loop
    
    let animationView = LottieAnimationView()
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        
        animationView.animation = LottieAnimation.named(name.rawValue)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.play()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // Optionally update view if needed
    }
}

enum LottieFiles : String {
    
    case loading = "loading"
    
}

