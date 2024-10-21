//
//  MoviesListViewModel.swift
//  MovieApp
//
//  Created by Pramuk.u on 20/10/24.
//

import Foundation

class MoviesListViewModel: ObservableObject {
    @Published var displayMovies: [Movie] = []
    @Published var showFilter = true
    var dispatchWorkItem: DispatchWorkItem?
    @Published var searchText: String = "" {
        didSet {
            dispatchWorkItem?.cancel()
            let workItem = DispatchWorkItem {
                self.handleSearch()
            }
            dispatchWorkItem = workItem
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.3, execute: workItem)
        }
    }
    var filterSelected: (filterType: FilterType, filterOption: String)? = nil
    var movies: [Movie] = []
    var filteredMovies = [Movie]()
    var years: [String] = []
    var genres: [String] = []
    var directors: [String] = []
    var actors: [String] = []
    
    /// initialiser
    init() {
        fetchMovies()
    }
    
    func handleSearch() {
        var showFilter: Bool = true
        if searchText.isEmpty {
            if filterSelected != nil {
                displayMovies = filteredMovies
            } else {
                showFilter = true
                displayMovies = movies
            }
        } else {
            let data = filterSelected != nil ? filteredMovies : movies
            filterBasedOnSearch(data: data)
            showFilter = false
        }
//        DispatchQueue.main.async {
//            showFilter =
//        }
    }
    
    /// function to fetch the movies
    private func fetchMovies() {
        movies = DataManager().loadMoviesData() ?? []
        displayMovies = movies
        // load filter data
        loadFilterData()
    }
    
    /// To load the filter options
    private func loadFilterData() {
        years = Array(Set(movies.map { $0.year ?? StringConstants.emptyString })).sorted()
        let genreArray = movies.flatMap { $0.genre?.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) } ?? [] }
        genres = Array(Set(genreArray)).sorted()
        let directorArray = movies.flatMap { $0.director?.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) } ?? [] }
        directors = Array(Set(directorArray)).sorted()
        let actorArray = movies.flatMap { $0.actors?.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) } ?? [] }
        actors = Array(Set(actorArray)).sorted()
    }
    
    /// function to get the filter options based on filterType
    /// - Parameter type: filter type
    /// - Returns: returns filter options
    func getFilterOptions(for type: FilterType) -> [String] {
        switch type {
        case .year: return years
        case .genre: return genres
        case .directors: return directors
        case .actors: return actors
        case .allMovies: return []
        }
    }
    
    /// function to filter the movies data
    /// - Parameters:
    ///   - type: type of filter selected
    ///   - value: filter option selected
    func filterData(for type: FilterType, value: String) {
        filterSelected = (type, value)
        switch type {
        case .year: displayMovies = movies.filter { $0.year?.localizedCaseInsensitiveContains(value) ?? false }
        case .genre: displayMovies = movies.filter { $0.genre?.localizedCaseInsensitiveContains(value) ?? false }
        case .directors: displayMovies = movies.filter { $0.director?.localizedCaseInsensitiveContains(value) ?? false }
        case .actors: displayMovies = movies.filter { $0.actors?.localizedCaseInsensitiveContains(value) ?? false }
        case .allMovies:
            displayMovies = movies
        }
        // filteredMovies - variable is used when search is applied for movies
        filteredMovies = displayMovies
    }
    
    /// function to filter movies based on search text
    /// - Parameter data: data on which filter is applied
    func filterBasedOnSearch(data: [Movie]) {
        displayMovies = data.filter { movie in
            movie.title?.localizedCaseInsensitiveContains(searchText) ?? false ||
            movie.genre?.localizedCaseInsensitiveContains(searchText) ?? false ||
            movie.actors?.localizedCaseInsensitiveContains(searchText) ?? false ||
            movie.director?.localizedCaseInsensitiveContains(searchText) ?? false
        }
    }
    
    /// clear applied filter option
    func clearSelectedFilter() {
        filterSelected = nil
        filteredMovies.removeAll()
        displayMovies = movies
        if searchText.isEmpty {
            showFilter = true
        } else {
            // If any text is searched show the result for the searched text
            filterBasedOnSearch(data: movies)
        }
    }
}
