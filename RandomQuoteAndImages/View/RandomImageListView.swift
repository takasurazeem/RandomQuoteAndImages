//
//  RandomImageListView.swift
//  RandomQuoteAndImages
//
//  Created by Mohammad Azam on 7/14/21.
//

import SwiftUI

struct RandomImageListView: View {
    
    @StateObject private var viewModel = RandomImageListViewModel()
    
    var body: some View {
        List(viewModel.randomImages) { randomImage in
            HStack {
                randomImage.image.map {
                    Image(uiImage: $0)
                        .resizable()
                        .scaledToFit()
                }
                Text(randomImage.quote)
            }
        }
        .task {
            await viewModel.getRandomImages(ids: Array(100...120))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RandomImageListView()
    }
}
