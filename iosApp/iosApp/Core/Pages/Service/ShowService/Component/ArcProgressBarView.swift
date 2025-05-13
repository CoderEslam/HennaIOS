//
//  ArcProgressBarView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 14/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct ArcProgressBarView: View {
    var progress: CGFloat // Progress from 0 to 1
    var count : Int
    var number : Int
    var startAngle: Angle = .degrees(180)
    var endAngle: Angle = .degrees(360)
    var lineWidth: CGFloat = 10
    var foregroundColor: Color = Color.theme.logoPink
    var backgroundColor: Color = Color.gray.opacity(0.2)
    
    var body: some View {
        ZStack {
            ArcShape(startAngle: startAngle, endAngle: endAngle)
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .foregroundColor(backgroundColor)
            
            ArcShape(startAngle: startAngle, endAngle: endAngle * (progress + 0.5))
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .foregroundColor(foregroundColor)
                .animation(.easeOut(duration: 1.5), value: progress) // animate progress change
            
            VStack {
                Text("\(count)")
                    .font(.system(size: 14))
                    .foregroundColor(.black)
                    .offset(y: lineWidth / 2)
                
                HStack {
                    Text("\(number) ")
                        .font(.system(size: 12))
                        .foregroundColor(.black)
                        .offset(y: lineWidth / 2)
                    
                    Text("star".localized)
                        .lineLimit(1)
                        .font(.system(size: 12))
                        .foregroundColor(.black)
                        .offset(y: lineWidth / 2)
                }
                
            }
        }.padding(8)
            .frame(maxWidth: .infinity,maxHeight: .infinity)
        // Adjust for arc size
    }
}

struct ArcShape: Shape {
    var startAngle: Angle
    var endAngle: Angle

    func path(in rect: CGRect) -> Path {
        let radius = min(rect.width, rect.height) / 2
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        var path = Path()
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        return path
    }
}

#Preview {
    ArcProgressBarView(progress: 0.1, count: 5, number: 4)
}
