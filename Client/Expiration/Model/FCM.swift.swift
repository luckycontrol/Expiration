//
//  FCM.swift.swift
//  FCM.swift
//
//  Created by 조종운 on 2021/08/21.
//

import Foundation

struct RequestFCM: Codable {
    let token: String
    let email: String
}

struct ResponseFCM: Codable {
    let result: String
}
