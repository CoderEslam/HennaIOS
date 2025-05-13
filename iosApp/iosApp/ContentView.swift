import UIKit
import SwiftUI
import ComposeApp


struct ComposeView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        MainViewControllerKt.MainViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct GameView : UIViewControllerRepresentable {
    let endGame:()-> Void
    func makeUIViewController(context: Context) -> UIViewController {
        MainViewControllerKt.GameViewController(endGame: {
            endGame()
        })
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct LoadImageView : UIViewControllerRepresentable {
    var image:String
    func makeUIViewController(context: Context) -> UIViewController {
        MainViewControllerKt.LoadImage(image: image)
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

extension LoadImageView {
    static func loadImage(url: String) -> some View {
        LoadImageView(image : url)
    }
}

struct LoadPostContentView : UIViewControllerRepresentable {
    var postModel : PostModel
    func makeUIViewController(context: Context) -> UIViewController {
        MainViewControllerKt.LoadPostContent(postModel: postModel)
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct ArcProgressView : UIViewControllerRepresentable {
    var progress : Float
    var onProgressChanged:(Float) -> Void
    func makeUIViewController(context: Context) -> UIViewController {
        MainViewControllerKt.ArcProgress(progress: progress) { f in
            onProgressChanged(Float(truncating: f))
        }
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}


//struct SpinnerContentView : UIViewControllerRepresentable {
//
//    var items: [Any]
//    var selectedItem: Any?
//    var onItemSelected: (Any?) -> Void
//    var itemToString: (Any?) -> String
//
//    func makeUIViewController(context: Context) -> UIViewController {
//        MainViewControllerKt.SpinnerView(items: items, selectedItem: selectedItem) { a in
//            onItemSelected(a)
//        } itemToString: { a in
//            itemToString(a)
//        }
//
//    }
//
//    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
//}

struct SpinnerContentView<T>: UIViewControllerRepresentable {
    var items: [T]
    var selectedItem: T?
    var onItemSelected: (T?) -> Void
    var itemToString: (T?) -> String

    func makeUIViewController(context: Context) -> UIViewController {
        MainViewControllerKt.SpinnerView(items: items, selectedItem: selectedItem) { selected in
            onItemSelected(selected as? T)
        } itemToString: { item in
            itemToString(item as? T)
        }
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct PagerView : UIViewControllerRepresentable {
    let gameModelList:[GameModel]
    let endGame:()-> Void
    func makeUIViewController(context: Context) -> UIViewController {
        MainViewControllerKt.PagerViewController(gameModelList: gameModelList, endGame: {
            endGame()
        })
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct ContentView: View {
    //@Environment(\.locale) var locale
    @StateObject private var userDataViewModel = SettingsViewModel()
    var body: some View {
        SplashView()
            .environment(\.locale, Locale(identifier: "\(userDataViewModel.getAppLang())")) // Spanish
            .onAppear{
                //Bundle.setLanguage(userDataViewModel.getAppLang())
            }
//        ComposeView()
//                .ignoresSafeArea(.keyboard) // Compose has own keyboard handler
    }
}
