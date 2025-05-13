//
//  Date.swift
//  iosApp
//
//  Created by Eslam Ghazy on 14/2/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation


extension Date {
     func toString(_ withFormat: String = "hh:mm") -> String {
        let formatter = DateFormatter()
         formatter.dateFormat = withFormat
         formatter.locale = .current
        return formatter.string(from: self)
    }
    
    init(date: String?, _ withFormat: String = "hh:mm") {
        guard let date else {
            self = date?.toDate() ?? Date()
            return
        }
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = withFormat
        guard let dateTime =  formatter.date(from: date) else {
            self = date.toDate()
            return
        }
        self = dateTime
    }
}

