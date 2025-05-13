//
//  PageModel.swift
//  iosApp
//
//  Created by Eslam Ghazy on 7/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation

struct PageModel: Identifiable {
    
    var id = UUID()
    var name :String
    var description:String
    var imageUrl:String
    var tag:Int
    
    
    static var page = PageModel(
        name: "Name",
        description: "Description",
        imageUrl: "i1",
        tag: 0
    )
    
    
    static var pages : [PageModel] = [
        PageModel(
            name: "\"Exceeding your wedding expectations\"",
            description: "\"Welcome to our wedding services app, where we help make your dream wedding a reality.\"",
            imageUrl: "image1",
            tag: 0
        ),
        PageModel(
            name: "\"Exceeding your wedding expectations\"",
            description: "\"Discover a wide range of wedding services to make your special day perfect, all on our app.\"",
            imageUrl: "image2",
            tag: 1
        ),
        PageModel(
            name: "\"Exceeding your wedding expectations\"",
            description: "\"Enjoy a seamless and stress-free wedding planning experience with our app's comprehensive services.\"",
            imageUrl: "image3",
            tag: 2
        )
    ]
    
}
