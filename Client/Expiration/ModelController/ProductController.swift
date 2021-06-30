//
//  ProductController.swift
//  Expiration
//
//  Created by 조종운 on 2021/06/28.
//

import Foundation

class ProductApi: ObservableObject {
    let url = "http://0.0.0.0:5000/product"
    
    // 데이터 읽기
    func readProduct(_ username: String, completion: @escaping ([ResponseReadProduct]) -> ()) {
        if let url = URL(string: url + "/readProduct") {
            let user = ["username": username]
            
            var request = URLRequest(url: url)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            request.httpBody = try? JSONEncoder().encode(user)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    if let result = try? JSONDecoder().decode(ResponseReadProductResult.self, from: data) {
                        DispatchQueue.main.async {
                            completion(result.result)
                        }
                    }
                }
                
                print("데이터 읽기 응답 에러")
            }.resume()
        }
    }
    
    // 데이터 쓰기
    func createProduct(_ product: RequestCreateProduct, completion: @escaping (String) -> ()) {
        if let url = URL(string: url + "/createProduct") {
            
            var request = URLRequest(url: url)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            request.httpBody = try? JSONEncoder().encode(product)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    if let result = try? JSONDecoder().decode(ResponseCreateProduct.self, from: data) {
                        completion(result.result)
                    }
                }
                
                print("데이터 생성 응답 에러")
            }.resume()
        }
    }
    
    // 데이터 업데이트
    
    // 데이터 삭제
}

