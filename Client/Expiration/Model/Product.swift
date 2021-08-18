//
//  Category.swift
//  Expiration
//
//  Created by 조종운 on 2021/05/12.
//

import SwiftUI

// MARK: Product 생성
struct RequestCreateProduct: Codable {
    var email: String
    var productName: String
    var category: String
    var image: String
    var expiration: String
}

struct ResponseCreateProduct: Codable {
    var result: String
    var product: ProductStructure?
}


// MARK: Product 리스트 가져오기
struct RequestProductList: Codable {
    var email: String
    var category: String
}

struct ResponseProductList: Codable {
    var productList: [ProductStructure]
}


// MARK: Product 리스트 삭제
struct RequestRemoveProductList: Codable {
    var email: String
    var categoryName: String
}

struct ResponseRemoveProductList: Codable {
    var result: String
}


// MARK: Product 업데이트
struct RequestUpdateProduct: Codable {
    var email: String
    var _id: String
    var name: String
    var type: String
    var expiration: String
}

struct ResponseUpdateProduct: Codable {
    var result: String
}


// MARK: Product 삭제
struct RequestRemoveProduct: Codable {
    var email: String
    var _id: String
}

struct ResponseRemoveProduct: Codable {
    var result: String
}


// MARK: Product 구조
struct ProductStructure: Codable {
    var _id: String
    var email: String
    var name: String
    var type: String
    var image: String
    var expiration: String
}
