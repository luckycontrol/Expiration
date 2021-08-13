//
//  Member.swift
//  Expiration
//
//  Created by 조종운 on 2021/06/28.
//

import Foundation

// MARK: 멤버 생성
struct RequestCreateAccount: Codable {
    var email: String
    var name: String
    var password: String
}

struct ResponseCreateAccount: Codable {
    var result: String
}

// MARK: 멤버 검색 ( 이메일 중복 확인 )
struct RequestCheckEmailDuplicate: Codable {
    var email: String
}

struct ResponseCheckEmailDuplicate: Codable {
    var result: String
}

// MARK: 멤버 비밀번호 변경
struct RequestChangeMemberPassword: Codable {
    var username: String
    var password: String
    var newPassword: String
}

struct ResponseChangeMemberPassword: Codable {
    var result: String
}

// MARK: 멤버 삭제
struct RequestDeleteMember: Codable {
    var username: String
}

struct ResponseDeleteMember: Codable {
    var result: String
}

// MARK: 로그인
struct RequestLoginModel: Codable {
    var email: String
    var password: String
}

struct LoginModel: Codable {
    var result: String
    var email: String?
    var name: String?
}
