//
//  RatingDetailViewModel.swift
//  MovieApp
//
//  Created by Pramuk.u on 20/10/24.
//

import Foundation

class RatingDetailViewModel {

    /// To get the percentage value to show the rating process
    /// - Parameter rating: rating object for which percentage value to be calculated
    /// - Returns: returns the percentage value for the rating.
    func getPercentageValue(rating: Rating) -> Double {
        var percentage: Double = 0.0
        if rating.source == StringConstants.imdb {
            let rateValue = Double(rating.value?.split(separator: StringConstants.forwardSlashString).first ?? "") ?? 0
            percentage = rateValue * 10
        } else if rating.source == StringConstants.rottenTomatoes {
            percentage = Double(rating.value?.replacingOccurrences(of: StringConstants.percentageString, with: StringConstants.emptyString) ?? StringConstants.emptyString) ?? 0
        } else if rating.source == StringConstants.metacritic {
            percentage = Double(rating.value?.split(separator: StringConstants.forwardSlashString).first ?? "") ?? 0
        }
        return percentage
    }
}
