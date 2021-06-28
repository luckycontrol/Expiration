//
//  Category.swift
//  Expiration
//
//  Created by 조종운 on 2021/05/12.
//

import SwiftUI

struct ProductResult: Codable {
    var result: [Product]
}

struct Product: Identifiable, Hashable, Codable {
    var id: UUID
    var productCategory: String
    var productName: String
    var productImage: String
    var expiration: Date
}

struct CreateProduct: Codable {
    var id: UUID
    var productCategory: String
    var productName: String
    var productImage: String
    var expiration: Date
    var username: String
}

struct Result: Codable {
    var result: String
}
