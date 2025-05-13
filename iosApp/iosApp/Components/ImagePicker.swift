//
//  ImagePicker.swift
//  iosApp
//
//  Created by Eslam Ghazy on 25/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation
import SwiftUI
import PhotosUI
import ComposeApp


struct ImagePicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    var completionHandler: (UIImage?) -> Void
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.completionHandler(image)
            } else {
                parent.completionHandler(nil)
            }
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.completionHandler(nil)
        }
    }
}

extension Data {
    func toKotlinByteArray() -> KotlinByteArray {
        let byteArray = KotlinByteArray(size: Int32(count))
        for (index, byte) in enumerated() {
            byteArray.set(index: Int32(index), value: Int8(bitPattern: byte))
        }
        return byteArray
    }
}
