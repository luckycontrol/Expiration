//
//  ProductController.swift
//  Expiration
//
//  Created by 조종운 on 2021/06/28.
//

import Foundation

class ProductApi: ObservableObject {
    @Published var products: [Product] = []
    
    let url = "http://0.0.0.0:5000/product"
    
    func readProduct(_ username: String) {
        if let url = URL(string: url + "/readProduct") {
            let user = ["username": username]
            
            var request = URLRequest(url: url)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            request.httpBody = try? JSONEncoder().encode(user)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    if let products = try? JSONDecoder().decode(ProductResult.self, from: data) {
                        self.products = products.result
                    }
                }
                
                print("Fetch Error")
            }.resume()
        }
    }
    
    func createProduct(_ username: String,_ product: Product, completion: @escaping (String) -> ()) {
        if let url = URL(string: url + "/createProduct") {
            let user = CreateProduct(
                id: UUID(),
                productCategory: product.productCategory,
                productName: product.productName,
                productImage: product.productImage,
                expiration: product.expiration,
                username: username
            )
            
            var request = URLRequest(url: url)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            request.httpBody = try? JSONEncoder().encode(user)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    if let result = try? JSONDecoder().decode(Result.self, from: data) {
                        completion(result.result)
                    }
                }
                
                print("Fetch Error")
            }.resume()
        }
    }
}

