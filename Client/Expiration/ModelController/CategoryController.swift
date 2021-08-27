//
//  CategoryController.swift
//  CategoryController
//
//  Created by 조종운 on 2021/08/13.
//

import Foundation

class CategoryApi {
    let url = "https://expiration-server.herokuapp.com/"
    
    // MARK: 카테고리 리스트 가져오기
    func getCategoryList(_ email: String, completion: @escaping ([String]) -> ()) {
        let categoryObject = RequestCategoryList(email: email)
        
        let request = makeRequestObject(categoryObject, url + "getCategoryList")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { print("데이터가 없음"); return }
            
            if let decoded = try? JSONDecoder().decode(ResponseCategoryListResult.self, from: data) {
                var categoryList: [String] = []
                
                for category in decoded.categoryList {
                    categoryList.append(category.categoryName)
                }
                
                completion(categoryList)
            }
        }.resume()
    }
    
    // MARK: 계정 생성할때 카테고리 리스트 만들기
    func createCategoryListWhenCreateAccount(_ email: String, completion: @escaping (Bool) -> ()) {
        let object = RequestCreateCategoryList(email: email)
        
        let request = makeRequestObject(object, url + "createCategoryList")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { print("데이터 없음"); return }
            
            if let decoded = try? JSONDecoder().decode(ResponseCreateCategoryList.self, from: data) {
                if (decoded.result == "성공") {
                    completion(true)
                    
                } else {
                    completion(false)
                }
            }
        }.resume()
    }
    
    // MARK: 카테고리 생성
    func createNewCategory(_ email: String, _ categoryName: String, completion: @escaping (Bool, String, String) -> ()) {
        let object = RequestCreateNewCategory(email: email, categoryName: categoryName)
        
        let request = makeRequestObject(object, url + "createCategory")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { print("데이터 없음"); return }
            
            if let decoded = try? JSONDecoder().decode(ResponseCreateNewCategory.self, from: data) {
                if (decoded.result == "중복") {
                    completion(false, "입력하신 카테고리가 이미 존재해요!", "")
                } else {
                    completion(true, "", decoded.categoryName!)
                }
            }
        }.resume()
    }
    
    
    // MARK: 카테고리 삭제
    func removeCategory(_ email: String, _ categoryName: String, completion: @escaping (Bool) -> ()) {
        let object = RequestRemoveCategory(email: email, categoryName: categoryName)
        
        let request = makeRequestObject(object, url + "removeCategory")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { print("데이터 없음"); return }
            
            if let decoded = try? JSONDecoder().decode(ResponseRemoveCategory.self, from: data) {
                if (decoded.result == "성공") {
                    completion(true)
                    return
                }
                
                completion(false)
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
