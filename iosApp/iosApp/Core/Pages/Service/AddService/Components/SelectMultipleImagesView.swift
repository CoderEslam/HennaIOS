//
//  SelectMultipleImagesView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 3/12/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import PhotosUI

struct SelectMultipleImagesView: View {
    @State private var images:[UIImage] = []
    @State private var imagesData:[Data] = []
    @State private var photoPickerItems:[PhotosPickerItem] = []
    var sendImage:([Data])->Void
    var body: some View {
        VStack{
            Image("upload_image")
                .padding(.vertical)
            
            PhotosPicker("select_photes".localized, selection: $photoPickerItems, maxSelectionCount: 5, selectionBehavior: .ordered, matching: .images)
            
            ScrollView(.horizontal,showsIndicators: false){
                HStack(spacing: 20){
                    ForEach(0..<images.count,id: \.self){ i in
                        Image(uiImage: images[i])
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Rectangle())
                            .cornerRadius(12)
                    }
                }
            }.padding()
                .onChange(of: photoPickerItems, perform: { value in
                    Task{
                        for item in photoPickerItems{
                            if let data = try? await item.loadTransferable(type: Data.self){
                                if let image = UIImage(data: data){
                                    guard let imageData = image.jpegData(compressionQuality: 0.1) else {
                                        print("Failed to convert image to data")
                                        return
                                    }
                                    images.append(image)
                                    imagesData.append(imageData)
                                }
                            }
                        }
                        sendImage(imagesData)
                        photoPickerItems.removeAll()
                    }
                })
        }.frame(maxWidth: .infinity)
            .frame(height: 200)
    }
}

#Preview {
    SelectMultipleImagesView(){ i in
        
    }
}
