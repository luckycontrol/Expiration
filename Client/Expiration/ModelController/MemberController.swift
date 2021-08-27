//
//  MemberController.swift
//  Expiration
//
//  Created by 조종운 on 2021/06/28.
//

import Foundation

class AccountApi {
    
    let url = "https://expiration-server.herokuapp.com/"
    
    // MARK: 멤버 생성
    func createAccount(_ email: String, _ name: String, _ password: String, completion: @escaping (Bool) -> ()) {
        let newMember = RequestCreateAccount(email: email, name: name, password: password)
        let request = makeRequestObject(newMember, url + "createAccount")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { print("데이터 없음"); return }
            
            if let decoded = try? JSONDecoder().decode(ResponseCreateAccount.self, from: data) {
                if (decoded.result == "성공") {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }.resume()
    }
    
    // MARK: 로그인
    func login(_ email: String, _ password: String, completion: @escaping (Bool, String, String, String) -> ()) {
        let user = RequestLoginModel(email: email, password: password)
        let request = makeRequestObject(user, url + "login")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { print("데이터 없음"); return }
            
            if let decoded = try? JSONDecoder().decode(LoginModel.self, from: data) {
                if (decoded.result == "성공") {
                    completion(true, decoded.email!, decoded.name!, "")
                } else {
                    completion(false, "", "", "입력하신 계정 정보가 올바르지 않습니다.")
                }
            } 
            
        }.resume()
    }
    
    // MARK: 중복확인
    func checkDuplicate(_ email: String, completion: @escaping (Bool) -> ()) {
        let object = RequestCheckEmailDuplicate(email: email)
        
        let request = makeRequestObject(object, url + "checkDuplicate")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { print("데이터 없음"); return }
            
            if let decoded = try? JSONDecoder().decode(ResponseCheckEmailDuplicate.self, from: data) {
                if (decoded.result == "중복") {
                    completion(true)
                } else {
                    completion(false)
                }
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
