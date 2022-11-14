//
//  RandomImageListViewModel.swift
//  RandomQuoteAndImages
//
//  Created by Takasur Azeem on 14/11/2022.
//

import UIKit

@MainActor
class RandomImageListViewModel: ObservableObject {
    
    @Published private(set) var randomImages: [RandomImageViewModel] = []
    
    /// gets random images and quotes from APIs
    /// - Parameter ids: Not really ids but number of images to fetch from server, will change this later.
    func getRandomImages(ids: [Int]) async {
        // TODO: - Change this fake ids thing to number of images and cleanup
        do {
            let randomImages = try await Webservice().getRandomImages(ids: ids)
            self.randomImages = randomImages.map(RandomImageViewModel.init)
        } catch {
            print(error)
        }
    }
}

struct RandomImageViewModel: Identifiable {
    let id = UUID()
    fileprivate let randomImage: RandomImage
    
    var image: UIImage? {
        UIImage(data: randomImage.image)
    }
    
    var quote: String {
        randomImage.quote.content
    }
}
