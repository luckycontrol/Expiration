//
//  Card.swift
//  Expiration
//
//  Created by 조종운 on 2021/05/12.
//

import SwiftUI

struct Card: View {
    
    var formatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        return dateFormatter
    }()
    
    let name: String
    let category: String
    let image: Data?
    let expiration: String
    
    init(_ product: ProductStructure) {
        name = product.name
        category = product.type
        image = product.image == "" ? nil : Data(base64Encoded: product.image)
        expiration = product.expiration
    }
    
    var body: some View {
        HStack {
            if (image != nil) {
                Image(uiImage: UIImage(data: image!)!)
                    .resizable()
                    .frame(width: 40, height: 40)
            } else {
                Image("LoginBackground")
                    .resizable()
                    .frame(width: 40, height: 40)
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Text(name)
                        .fontWeight(.medium)
                        .font(.headline)
                    
                    Image("유통기한 일주일남음")
                        .resizable()
                        .frame(width: 15, height: 15)
                }
                Text(expiration)
            }
            
            Spacer()
        }
        .padding(8)
    }
    

}

struct Card_Previews: PreviewProvider {
    
    static let product = ProductStructure(_id: "", email: "", name: "", type: "", image: "", expiration: "")
    
    static var previews: some View {
        Card(product)
    }
}
