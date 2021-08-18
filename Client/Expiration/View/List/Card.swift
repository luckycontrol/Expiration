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
    let image: UIImage?
    let expiration: String
    var status: String
    
    init(_ product: ProductStructure) {
        name = product.name
        category = product.type
        image = product.image == "" ? nil : loadImageInDocument(product.image)
        expiration = product.expiration
        
        let expiration_date = formatter.date(from: expiration)!
        let component = Calendar.current.dateComponents([.year, .month, .day], from: expiration_date)
        let productExpiration = Calendar.current.date(from: component)!
        
        let week = Calendar.current.date(byAdding: .day, value: -7, to: productExpiration)!
        let three = Calendar.current.date(byAdding: .day, value: -3, to: productExpiration)!
        let one = productExpiration
        
        if productExpiration < week {
            status = "유통기한 일주일남음"
        }
        if productExpiration < three {
            status = "유통기한 삼일남음"
        }
        if productExpiration <= one {
            status = "유통기한 하루남음"
        } else {
            status = "유통기한 지남"
        }
    }
    
    var body: some View {
        HStack {
            if (image != nil) {
                Image(uiImage: image!)
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
                    
                    Image(status)
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
    
    static let product = ProductStructure(_id: "", email: "", name: "사과", type: "음식", image: "", expiration: "2021년 8월 18일")
    
    static var previews: some View {
        Card(product)
    }
}
