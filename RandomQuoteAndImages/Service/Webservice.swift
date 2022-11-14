//
//  Webservice.swift
//  RandomQuoteAndImages
//
//  Created by Takasur Azeem on 14/11/2022.
//

import Foundation

class Webservice {
    
    func getRandomImages(ids: [Int]) async throws -> [RandomImage] {
        var randomImages: [RandomImage] = []
        
        try await withThrowingTaskGroup(of: (Int, RandomImage).self) { group in
            for id in ids {
                group.addTask { [self] in
                    return (id, try await getRandomImage(id: id))
                }
            }
            
            for try await (_, randomImage) in group {
                randomImages.append(randomImage)
            }
        }
        
        return randomImages
    }
    
    private func getRandomImage(id: Int) async throws -> RandomImage {
        guard let randomImageUrl = Constants.Urls.randomImage else { throw NetworkError.badUrl }
        guard let randomQuoteUrl = Constants.Urls.randomQuote else { throw NetworkError.badUrl }
        
        // both statements with async let will execute concurrently
        async let (imageData, _) = URLSession.shared.data(from: randomImageUrl)
        async let (quoteData, _) = URLSession.shared.data(from: randomQuoteUrl)
        
        // the task/thread will suspent when it hits first try await, i.e., `try await quoteData`
        guard let quote = try? JSONDecoder().decode(Quote.self, from: try await quoteData) else { throw NetworkError.decodingError }
        
        return RandomImage(image: try await imageData, quote: quote)
    }
    
}
