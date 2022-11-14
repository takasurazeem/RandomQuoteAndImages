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
    func getRandomImages(ids: [Int], appendingPreviousImages: Bool = false) async {
        // TODO: - Change this fake ids thing to number of images and cleanup
        let webService = Webservice()
        if appendingPreviousImages {
            randomImages = []
        }
        do {
            try await withThrowingTaskGroup(of: (Int, RandomImage).self) { group in
                for id in ids {
                    group.addTask {
                        return (id, try await webService.getRandomImage(id: id))
                    }
                }
                
                for try await (_, randomImage) in group {
                    randomImages.append(RandomImageViewModel(randomImage: randomImage))
                }
            }
        } catch {
            print(error)
        }
    }
}

struct RandomImageViewModel: Identifiable, Equatable {
    
    let id = UUID()
    fileprivate let randomImage: RandomImage
    
    var image: UIImage? {
        UIImage(data: randomImage.image)
    }
    
    var quote: String {
        randomImage.quote.content
    }
    
    static func == (lhs: RandomImageViewModel, rhs: RandomImageViewModel) -> Bool {
        lhs.id == rhs.id
    }
}
