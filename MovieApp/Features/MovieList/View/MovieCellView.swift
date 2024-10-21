//
//  MovieCellView.swift
//  MovieApp
//
//  Created by Pramuk.u on 20/10/24.
//

import SwiftUI

struct MovieCellView: View {
    @State var movie: Movie
    
    var body: some View {
        HStack {
            if let imageURL = URL(string: movie.poster ?? StringConstants.emptyString) {
                AsyncImage(url: imageURL) { poster in
                    poster
                        .resizable()
                        .frame(width: 80, height: 80)
                } placeholder: {
                    Image(systemName: StringConstants.moviePlaceholderImage)
                        .resizable()
                        .frame(width: 80, height: 80)
                }
            }
            VStack(alignment: .leading) {
                Text("\(StringConstants.title): \(movie.title ?? StringConstants.emptyString)")
                    .bold()
                Text("\(StringConstants.language): \(movie.language ?? StringConstants.emptyString)")
                    .font(.subheadline)
                Text("\(StringConstants.year): \(movie.year ?? StringConstants.emptyString)")
                    .font(.subheadline)
            }
        }
    }
}
