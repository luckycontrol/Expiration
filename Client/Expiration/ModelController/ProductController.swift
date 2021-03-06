//
//  ProductController.swift
//  Expiration
//
//  Created by 조종운 on 2021/06/28.
//

import Foundation

class ProductApi: ObservableObject {
    let url = "https://expiration-server.herokuapp.com/"
    
    // MARK: Product 생성
    func createProduct(_ product: RequestCreateProduct, completion: @escaping (Bool, ProductStructure?) -> ()) {
        let object = makeRequestObject(product, url + "createProduct")
        
        URLSession.shared.dataTask(with: object) { data, response, error in
            guard let data = data else { print("데이터 없음"); return }
            
            if let decoded = try? JSONDecoder().decode(ResponseCreateProduct.self, from: data) {
                if (decoded.result == "성공") {
                    completion(true, decoded.product)
                } else {
                    completion(false, nil)
                }
            }
        }.resume()
    }
    
    // MARK: Product 리스트 가져오기
    func getProductList(_ email: String, _ categoryName: String, completion: @escaping ([ProductStructure]) -> ()) {
        let object = RequestProductList(email: email, category: categoryName)
        
        let request = makeRequestObject(object, url + "getProductList")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { print("데이터 없음"); return }
            
            if let decoded = try? JSONDecoder().decode(ResponseProductList.self, from: data) {
                completion(decoded.productList)
                return
            }
            
            print("디코딩 실패")
        }.resume()
    }
    
    // MARK: 카테고리 삭제로인한 Product 리스트 삭제하기
    func removeProductList(_ email: String, _ categoryName: String, completion: @escaping (Bool) -> ()) {
        let object = RequestRemoveProductList(email: email, categoryName: categoryName)
        
        let request = makeRequestObject(object, url + "removeProductList")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { print("데이터 없음"); return }
            
            if let decoded = try? JSONDecoder().decode(ResponseRemoveProductList.self, from: data) {
                if (decoded.result == "성공") {
                    completion(true)
                    return
                }
                
                completion(false)
            }
        }.resume()
    }
    
    // MARK: Product 업데이트
    func updateProduct(_ object: RequestUpdateProduct, completion: @escaping (Bool) -> ()) {
        
        let request = makeRequestObject(object, url + "updateProduct")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { print("데이터 없음"); return }
            
            if let _ = try? JSONDecoder().decode(ResponseUpdateProduct.self, from: data) {
                completion(true)
            }
            
        }.resume()
    }
    
    // MARK: Product 삭제
    func removeProduct(_ email: String, _ _id: String, completion: @escaping (Bool) -> ()) {
        let object = RequestRemoveProduct(email: email, _id: _id)
        
        let request = makeRequestObject(object, url + "removeProduct")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { print("데이터 없음"); return }
            
            if let decoded = try? JSONDecoder().decode(ResponseRemoveProduct.self, from: data) {
                completion(true)
            }
        }.resume()
    }
    
    // MARK: Request 객체 만들어 반환
    func makeRequestObject<T: Codable> (_ requestObject: T, _ url: String) -> URLRequest {
        let url = URL(string: url)!
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(requestObject)
        
        return request
    }
}

