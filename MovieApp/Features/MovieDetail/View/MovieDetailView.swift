//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by Pramuk.u on 20/10/24.
//

import SwiftUI

struct MovieDetailView: View {
    var movie: Movie?
    var body: some View {
        VStack {
            if let imageURL = URL(string: movie?.poster ?? StringConstants.emptyString) {
                AsyncImage(url: imageURL) { poster in
                    poster
                        .resizable()
                        .frame(width: 240, height: 240)
                } placeholder: {
                    Image(systemName: StringConstants.moviePlaceholderImage)
                        .resizable()
                        .frame(width: 240, height: 240)
                }
            }// rating
            VStack {
                Text("\(movie?.title ?? StringConstants.emptyString)")
                    .bold()
                    .font(.title)
                    .padding()
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        DetailCellView(title: StringConstants.actors, description: movie?.actors ?? StringConstants.emptyString)
                        DetailCellView(title: StringConstants.released, description: movie?.released ?? StringConstants.emptyString)
                        DetailCellView(title: StringConstants.genre, description: movie?.genre ?? StringConstants.emptyString)
                        DetailCellView(title: StringConstants.language, description: movie?.language ?? StringConstants.emptyString)
                        DetailCellView(title: StringConstants.plot, description: movie?.plot ?? StringConstants.emptyString)
                        RatingView(ratings: movie?.ratings ?? [])
                    }
                }
            }
            .font(.subheadline)
        }
    }
}
