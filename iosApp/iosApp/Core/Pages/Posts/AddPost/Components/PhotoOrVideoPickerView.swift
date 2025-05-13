//
//  PhotoOrVideoPickerView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 3/12/24.
//  Copyright © 2024 orgName. All rights reserved.
//


import SwiftUI
import PhotosUI
import UniformTypeIdentifiers
import AVFoundation

struct PhotoOrVideoPickerView: View {
    @State private var image: UIImage?
    @State private var photoPickerItem: PhotosPickerItem?
    var content: (Data, String) -> Void // Pass data and type as parameters

    var body: some View {
        VStack {
            PhotosPicker(selection: $photoPickerItem, matching: .any(of: [.images/*, .videos*/])) {
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: 30, height: 25)
            }
        }.onChange(of: photoPickerItem, perform: { value in
            Task {
                if let photoPickerItem {
                    // Load the data and check its UTI
                    if let data = try? await photoPickerItem.loadTransferable(type: Data.self),
                       let typeIdentifier = photoPickerItem.supportedContentTypes.first?.identifier {
                        print("TYPE SELECT \(typeIdentifier)")
                        let isImage = typeIdentifier.contains("image") || typeIdentifier.contains("jpeg") || typeIdentifier.contains("png") || typeIdentifier.contains("jpg")
                        let isVideo = typeIdentifier.contains("video") || typeIdentifier.contains("movie")
                        // Update the image state if it's an image
                        if isImage, let image = UIImage(data: data) {
                            self.image = image
                            guard let imageData = image.jpegData(compressionQuality: 0.1) else {
                                print("Failed to convert image to data")
                                return
                            }
                            
                            // Pass the content and type
                            content(imageData , isImage ? "image" : isVideo ? "video" : "unknown")
                        }
                    }
                }
                photoPickerItem = nil
            }
        })
    }
}


#Preview {
    PhotoOrVideoPickerView(){ data , type in
        
    }
}
