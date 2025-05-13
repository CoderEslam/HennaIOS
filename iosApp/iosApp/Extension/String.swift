//
//  String.swift
//  iosApp
//
//  Created by Eslam Ghazy on 7/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation
import SwiftUI

extension String {
    
    var isNotEmpty : Bool {
        return !self.isEmpty && self != "nil" && self != ""
    }
    
    
    func translate() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
 
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let attributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: attributes)
        return size.width
    }
    
    func toDate(_ withFormat: String = "HH:mm:ss") -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = withFormat
        guard let date =  formatter.date(from: self) else { return Date() }
        return date
    }
    
    init(date: Date, _ withFormat: String = "hh:mm") {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = withFormat
        self =  formatter.string(from: date)
    }
    
    func toTime(_ withFormat: String = "yyyy-MM-dd HH:mm:ss") -> Date {
        let previousTimeFormatter = DateFormatter()
        previousTimeFormatter.locale = Locale.current
        previousTimeFormatter.dateFormat = "HH:mm"
        let date = previousTimeFormatter.date(from: self)
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = withFormat
        guard let date =  formatter.date(from: self) else { return Date() }
        return date
    }
    
}
