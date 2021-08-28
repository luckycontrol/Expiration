//
//  FCMController.swift
//  FCMController
//
//  Created by 조종운 on 2021/08/21.
//

import Foundation

final class FCMApi {
    let url = "https://expiration-server.herokuapp.com"
    
    func requestFCM(_ email: String,  _ token: String, completion: @escaping (Bool) -> ()) {
        let object = RequestFCM(token: token, email: email)
        let request = makeRequestObject(object, url + "/requestFCM")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { print("데이터 없음"); return }
            
            if let decoded = try? JSONDecoder().decode(ResponseFCM.self, from: data) {
                print(decoded)
                
                completion(true)
            }
        }.resume()
    }
    
    // MARK: Request 객체 만들어 반환
    private func makeRequestObject<T: Codable> (_ requestObject: T, _ url: String) -> URLRequest {
        let url = URL(string: url)!
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(requestObject)
        
        return request
    }
}
