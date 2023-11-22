//
//  ListModel.swift
//  Healthy
//
//  Created by Md Asadullah on 23/11/23.
//

import Foundation

struct ApiResponse: Codable {
    let Result: Result
}

struct Result: Codable {
    let Error: String
    let Total: Int
    let Language: String
    let Items: Items
}

struct Items: Codable {
    let Item: [Item]
}

struct Item: Codable {
    let Id: String
    let Title: String

    enum CodingKeys: String, CodingKey {
        case Id = "Id"
        case Title = "Title"
    }
}
