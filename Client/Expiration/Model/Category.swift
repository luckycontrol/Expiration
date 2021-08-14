//
//  Category.swift.swift
//  Category.swift
//
//  Created by 조종운 on 2021/08/12.
//

import Foundation

// MARK: 카테고리 목록 요청 및 응답
struct RequestCategoryList: Codable {
    var email: String
}

struct ResponseCategoryListResult: Codable {
    var categoryList: [ResponseCategoryList]
}

struct ResponseCategoryList: Codable, Hashable {
    var categoryName: String
}

// MARK: 계정 생성할 때 카테고리 리스트 생성 ( 음식, 생활용품 )
struct RequestCreateCategoryList: Codable {
    var email: String
}

struct ResponseCreateCategoryList: Codable {
    var result: String
}

// MARK: 카테고리 생성
struct RequestCreateNewCategory: Codable {
    var email: String
    var categoryName: String
}

struct ResponseCreateNewCategory: Codable {
    var result: String
    var categoryName: String?
}

// MARK: 카테고리 삭제
struct RequestRemoveCategory: Codable {
    var email: String
    var categoryName: String
}

struct ResponseRemoveCategory: Codable {
    var result: String
}
