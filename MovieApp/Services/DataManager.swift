//
//  DataManager.swift
//  MovieApp
//
//  Created by Pramuk.u on 20/10/24.
//

import Foundation

class DataManager {
    
    func loadMoviesData() -> [Movie]? {
        let fileName = "movies"
        let fileExtension = "json"
        guard let fileUrl = Bundle.main.url(
            forResource: fileName,
            withExtension: fileExtension
        ) else {
            print("Failed to find file movies in bundle.")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: fileUrl)
            let decodedData = try JSONDecoder().decode([Movie].self, from: data)
            return decodedData
        } catch {
            print("Failed to decode movies")
            return nil
        }
    }
}
