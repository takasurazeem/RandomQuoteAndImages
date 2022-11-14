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
        NavigationView {
            List(viewModel.randomImages) { randomImage in
                HStack {
                    randomImage.image.map {
                        Image(uiImage: $0)
                            .resizable()
                            .scaledToFit()
                    }
                    Text(randomImage.quote)
                }
                .onAppear {
                    if randomImage == viewModel.randomImages.last {
                        Task {
                            await viewModel.getRandomImages(ids: Array(100...120))
                        }
                    }
                }
            }
            .task {
                await viewModel.getRandomImages(ids: Array(100...120))
            }
            .toolbar {
                Button {
                    Task {
                        await viewModel.getRandomImages(ids: Array(100...120), appendingPreviousImages: true)
                    }
                } label: {
                    Image(systemName: "arrow.clockwise.circle")
                }
            }
            .navigationTitle("Random Images/Quotes")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RandomImageListView()
    }
}
