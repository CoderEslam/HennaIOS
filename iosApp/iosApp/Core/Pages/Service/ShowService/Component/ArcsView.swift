//
//  ArcsView.swift
//  iosApp
//
//  Created by Eslam Ghazy on 27/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import ComposeApp

struct ArcsView: View {
    
    let data: ServiceModel
    @State private var totalReviews1 = 0
    @State private var totalReviews2 = 0
    @State private var totalReviews3 = 0
    @State private var totalReviews4 = 0
    @State private var totalReviews5 = 0
    @State private var totalStars = 0.0
    @State private var star1 = 0.0
    @State private var star2 = 0.0
    @State private var star3 = 0.0
    @State private var star4 = 0.0
    @State private var star5 = 0.0
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                ArcProgressBarView(progress: calculatePercentageTotalRate(c: star5), count: totalReviews5, number: 5)
                    .frame(width: 80,height: 80)
                ArcProgressBarView(progress: calculatePercentageTotalRate(c: star4), count: totalReviews4, number: 4)
                    .frame(width: 75,height: 75)
                ArcProgressBarView(progress: calculatePercentageTotalRate(c: star3), count: totalReviews3, number: 3)
                    .frame(width: 70,height: 70)
                ArcProgressBarView(progress: calculatePercentageTotalRate(c: star2), count: totalReviews2, number: 2)
                    .frame(width: 65,height: 65)
                ArcProgressBarView(progress: calculatePercentageTotalRate(c: star1), count: totalReviews1, number: 1)
                    .frame(width: 60,height: 60)
            }.onAppear{
                setReview()
            }
        }
    }
    
    func setReview(){
        let list = data.reviews
        list?.forEach({ item in
            if (item.rate == 1) {
                star1 += Double(truncating: item.rate ?? 0.0)
                totalReviews1 += 1
            }
            if (item.rate == 2) {
                star2 += Double(truncating: item.rate ?? 0.0)
                totalReviews2 += 1
            }
            if (item.rate == 3) {
                star3 += Double(truncating: item.rate ?? 0.0)
                totalReviews3 += 1
            }
            if (item.rate == 4) {
                star4 += Double(truncating: item.rate ?? 0.0)
                totalReviews4 += 1
            }
            if (item.rate == 5) {
                star5 += Double(truncating: item.rate ?? 0.0)
                totalReviews5 += 1
            }
        })
        totalStars = Double(star1 + star2 + star3 + star4 + star5)
    }
    
    func calculatePercentageTotalRate(c: Double) -> Double {
        do {
            print("\(c / totalStars)")
            if ( c / totalStars) >= 0.5 {
               return 0.5
            } else {
                return (Double(c) / totalStars)
            }
        } catch {
            return 0.0
        }
    }

}

#Preview {
    ArcsView(data: ServiceModel(category: nil, category_id: 1, currency: nil, currency_id: 1, description: "", favorites: nil, favorites_count: 1, id: 1, max_price: 1, min_price: 1, name: "", provider: nil, provider_id: 1, reviews: nil, reviews_count: 1, service_image: ""))
}
