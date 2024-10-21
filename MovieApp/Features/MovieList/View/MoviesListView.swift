//
//  MoviesListView.swift
//  MovieApp
//
//  Created by Pramuk.u on 20/10/24.
//

import SwiftUI

struct MoviesListView: View {
    @StateObject var moviesListViewModel = MoviesListViewModel()
    @State var selectedMovie: Movie?
    @State var isSearching = false
    
    var body: some View {
        NavigationStack {
            VStack {
                // To show the selected filter options
                if let filterSelected = moviesListViewModel.filterSelected {
                    HStack {
                        Text("\(filterSelected.filterType) - \(filterSelected.filterOption)")
                        Button {
                            // Clear filter selected
                            moviesListViewModel.clearSelectedFilter()
                        } label: {
                            Image(systemName: StringConstants.closeImage)
                        }
                        Spacer()
                    }
                    .padding()
                }
                VStack(alignment: .leading) {
                    if moviesListViewModel.displayMovies.isEmpty {
                        VStack {
                            Spacer()
                            Text(StringConstants.noMoviesMessage)
                            Spacer()
                        }
                    } else {
                        VStack(spacing: 0) {
                            if moviesListViewModel.showFilter {
                                ForEach(FilterType.allCases, id: \.self) { filter in
                                    FilterCellView (
                                        filter: filter,
                                        filterOption: moviesListViewModel.getFilterOptions(for: filter)
                                    ) { filter, filterString in
                                        moviesListViewModel.filterData(for: filter, value: filterString)
                                        moviesListViewModel.showFilter = false
                                    }
                                }
                                Spacer()
                            } else {
                                List(moviesListViewModel.displayMovies) { movie in
                                    NavigationLink(destination: {
                                        MovieDetailView(movie: movie)
                                    }, label: {
                                        MovieCellView(movie: movie)
                                    })
                                }
                            }
                        }
                    }
                }
            }
            .searchable(
                text: $moviesListViewModel.searchText,
                prompt: StringConstants.searchPlaceholder
            )
            .navigationTitle(StringConstants.movieListTitle)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    MoviesListView()
}
