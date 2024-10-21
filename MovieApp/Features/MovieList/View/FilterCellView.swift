//
//  FilterCellView.swift
//  MovieApp
//
//  Created by Pramuk.u on 20/10/24.
//

import SwiftUI

struct FilterCellView: View {
    @State var filter: FilterType
    @State var showDetail: Bool = false
    var filterOption = [String]()
    var filterSelectedCallback: (FilterType, String) -> Void

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(filter.rawValue.capitalized)
                Spacer()
                Image(systemName: showDetail ? StringConstants.filterUpImage : StringConstants.filterDownImage)
            }
            .background(Color.white)
            .onTapGesture {
                if filter == .allMovies {
                    // show all movies
                    filterSelectedCallback(filter, StringConstants.emptyString)
                } else {
                    showDetail.toggle()
                }
            }
            Divider()
            if showDetail {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        ForEach(filterOption, id: \.self) { value in
                            Text(value)
                                .onTapGesture {
                                    // callback here to apply the selected filter options
                                    filterSelectedCallback(filter, value)
                                }
                                .font(.subheadline)
                        }
                    }
                }
            }
        }
        .padding()
    }
}
