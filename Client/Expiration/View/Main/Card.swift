//
//  Card.swift
//  Expiration
//
//  Created by 조종운 on 2021/05/12.
//

import SwiftUI

struct Card: View {
    
    let testdata: [String: Any] = ["name": "apple", "image": "test", "expiration": Date()]
    
    var formatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        return dateFormatter
    }()
    
    var body: some View {
        HStack {
            Image(testdata["image"] as! String)
                .resizable()
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(testdata["name"] as! String)
                        .fontWeight(.medium)
                        .font(.headline)
                    
                    Image("유통기한 일주일남음")
                        .resizable()
                        .frame(width: 15, height: 15)
                }
                Text(testdata["expiration"] as! Date, formatter: formatter)
            }
            
            Spacer()
        }
        .padding(8)
    }
    

}

struct Card_Previews: PreviewProvider {
    
    static var previews: some View {
        Card()
    }
}
