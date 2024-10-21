//
//  FilterType.swift
//  MovieApp
//
//  Created by Pramuk.u on 20/10/24.
//

import Foundation

/// Type of filters
enum FilterType: String, CaseIterable {
    case year
    case genre
    case directors
    case actors
    case allMovies = "All Movies"
}
