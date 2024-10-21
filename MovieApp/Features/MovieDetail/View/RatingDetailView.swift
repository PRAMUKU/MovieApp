//
//  RatingDetailView.swift
//  MovieApp
//
//  Created by Pramuk.u on 20/10/24.
//

import SwiftUI

struct RatingDetailView: View {
    var percentage: Double
    var title: String
    var progressText: String
    
    var body: some View {
        VStack {
            CircularRatingView(percentage: percentage, progressText: progressText)
            Text(title)
                .bold()
        }
    }
}

struct CircularRatingView: View {
    var percentage: Double
    var progressText: String

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 4)
            Circle()
                .trim(from: 0, to: CGFloat(percentage / 100))
                .stroke(Color.yellow, lineWidth: 8)
                .rotationEffect(.degrees(-90))
            Text(progressText)
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width/3 - 20)
    }
}
