//
//  AppModel.swift
//  Expiration
//
//  Created by 조종운 on 2021/05/12.
//

import SwiftUI
import CoreData

class AppModel: ObservableObject {
    @Published var selectedCateogry = "음식"
    @Published var selectedOrderWay = "유통기한 순"
}
