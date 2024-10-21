//
//  RatingView.swift
//  MovieApp
//
//  Created by Pramuk.u on 20/10/24.
//

import SwiftUI

struct RatingView: View {
    @State var showDetail: Bool = false
    var ratings: [Rating]
    var ratingDetailViewModel = RatingDetailViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(StringConstants.ratings): ")
                Spacer()
                Image(systemName: showDetail ? StringConstants.filterUpImage : StringConstants.filterDownImage)
            }
            .font(.headline)
            .background(Color.white)
            .onTapGesture {
                showDetail.toggle()
            }
            if showDetail {
                HStack(alignment: .top) {
                    ForEach(ratings, id: \.source) { rating in
                        RatingDetailView(
                            percentage: ratingDetailViewModel.getPercentageValue(rating: rating),
                            title: rating.source ?? StringConstants.emptyString,
                            progressText: rating.value ?? StringConstants.emptyString
                        )
                    }
                }
            }
            Divider()
        }.padding()
    }
}
