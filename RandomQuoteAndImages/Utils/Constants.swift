//
//  Constants.swift
//  RandomQuoteAndImages
//
//  Created by Takasur Azeem on 14/11/2022.
//

import Foundation

enum Constants {
    enum Urls {
        static var randomImage: URL? {
            URL(string: "https://picsum.photos/200/300?\(UUID().uuidString)")
        }
        
        static var randomQuote: URL? {
            URL(string: "https://api.quotable.io/random")
        }
    }
}
