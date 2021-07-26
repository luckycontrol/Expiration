//
//  MemberController.swift
//  Expiration
//
//  Created by 조종운 on 2021/06/28.
//

import Foundation

class MemberApi {
    
    let url = "http://127.0.0.1:3000/member"
    
    // MARK: 멤버 생성
    func createMember(_ username: String, _ password: String, completion: @escaping (String) -> ()) {
        let newMember = RequestCreateMember(username: username, password: password)
        let request = makeRequestObject(newMember, url + "/createMember")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let result = try? JSONDecoder().decode(ResponseCreateMember.self, from: data) {
                    DispatchQueue.main.async { completion(result.result) }
                }
            }
            
            print("계정 생성 에러")
        }.resume()
    }
    
    // MARK: 멤버 중복 확인
    func checkMemberDuplicate(_ username: String, completion: @escaping (String) -> (Bool)) {
        let checkEmail = RequestCheckEmailDuplicate(username: username)
        let request = makeRequestObject(checkEmail, url + "/checkMember")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let checkResult = try? JSONDecoder().decode(ResponseCheckEmailDuplicate.self, from: data) {
                    DispatchQueue.main.async { completion(checkResult.result) }
                }
            }
            
            print("중복 체크 에러")
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
