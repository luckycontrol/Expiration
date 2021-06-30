//
//  Category.swift
//  Expiration
//
//  Created by 조종운 on 2021/05/12.
//

import SwiftUI

// Product 생성
struct RequestCreateProduct: Codable {
    var productCategory: String
    var productName: String
    var productImage: String
    var expiration: String
    var username: String
}

struct ResponseCreateProduct: Codable {
    var result: String
}

// Product 읽기
struct RequestReadProduct: Codable {
    var username: String
}

struct ResponseReadProductResult: Codable {
    var result: [ResponseReadProduct]
}

struct ResponseReadProduct: Codable {
    var _id: String
    var productCategory: String
    var productName: String
    var productImage: String
    var expiration: String
}

// Product 업데이트

// Product 삭제
