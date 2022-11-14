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
        
        for id in ids {
            let randomImage = try await getRandomImage(id: id)
            randomImages.append(randomImage)
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
