//
//  RandomImage.swift
//  RandomQuoteAndImages
//
//  Created by Takasur Azeem on 14/11/2022.
//

import Foundation

struct RandomImage: Decodable {
    let image: Data
    var quote: Quote
}

struct Quote: Decodable {
    let content: String
}
