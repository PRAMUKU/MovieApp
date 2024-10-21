//
//  DetailCellView.swift
//  MovieApp
//
//  Created by Pramuk.u on 20/10/24.
//

import SwiftUI

struct DetailCellView: View {
    var title: String
    var description: String
    var body: some View {
        HStack(alignment: .top) {
            Text("\(title): ")
                .font(.headline)
            Text(description) 
        }
        .padding()
        Divider()
    }
}
