//
//  RangeSliderView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 5/12/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import Sliders

struct RangeSliderView: View {
    @State var range = 1.0...60000.0
    var myRange:(ClosedRange<Double>) -> Void
    var body: some View {
        RangeSlider(range: $range, distance: 0.1 ... 1.0)
            .rangeSliderStyle(
                HorizontalRangeSliderStyle(
                    track:
                        HorizontalRangeTrack(
                            view: Capsule().foregroundColor(Color.theme.logoPink)
                        )
                        .background(Capsule().foregroundColor(Color.theme.logoPink.opacity(0.25)))
                        .frame(height: 8),
                    lowerThumb: Circle().foregroundColor(Color.theme.logoPink),
                    upperThumb: Circle().foregroundColor(Color.theme.logoPink),
                    lowerThumbSize: CGSize(width: 32, height: 32),
                    upperThumbSize: CGSize(width: 32, height: 32),
                    options: .forceAdjacentValue
                )
            ).onChange(of: range, perform: { newValue in
                myRange(newValue)
            })
    }
}

#Preview {
    RangeSliderView{ r in
        
    }
}


