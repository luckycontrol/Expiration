//
//  AppModel.swift
//  Expiration
//
//  Created by 조종운 on 2021/05/12.
//

import SwiftUI
import CoreData

class AppModel: ObservableObject {
    // MARK: 선택된 카테고리
    @Published var selectedCateogry = "음식"
    @Published var categoryList: [String] = []
    
    // MARK: 선택된 정렬방식
    @Published var selectedOrderWay = "유통기한 순"
    
    // MARK: 로그인 유무
    @Published var isLogin = false
    
    // MARK: 로그인된 사용자 이메일
    @Published var email = ""
    @Published var name = ""
}
