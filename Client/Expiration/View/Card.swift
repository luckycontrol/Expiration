//
//  Card.swift
//  Expiration
//
//  Created by 조종운 on 2021/05/12.
//

import SwiftUI

struct Card: View {
    
    @Binding var edit: Bool
    
    let data: Product
    
    let test: Category
    
    var formatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        return dateFormatter
    }()
    
    var body: some View {
        VStack {
            HStack {
//                if let imageData = data.image {
//                    if let uiImage = UIImage(data: imageData) {
//                        Image(uiImage: uiImage)
//                            .resizable()
//                            .frame(width: 50, height: 50)
//                    }
//                }
//                    
//                VStack(alignment: .leading) {
//                    Text(data.name ?? "")
//                        .font(.headline)
//                    Text(data.expiration ?? Date(), formatter: formatter)
//                }
                Image("test")
                    .resizable()
                    .frame(width: 50, height: 50)
                
                VStack(alignment: .leading) {
                    Text(test.name)
                        .font(.headline)
                    Text(test.expiration, formatter: formatter)
                }
                
                Spacer()
                
                if edit {
                    HStack {
                        Button(action: {}) {
                            Rectangle()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.white)
                                .shadow(color: .primary.opacity(0.1), radius: 2, x: 2, y: 2)
                                .shadow(color: .primary.opacity(0.1), radius: 2, x: -1, y: -1)
                                .overlay(
                                    Text("편집")
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                )
                        }
                        
                        Button(action: {}) {
                            Rectangle()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.white)
                                .shadow(color: .primary.opacity(0.1), radius: 2, x: 2, y: 2)
                                .shadow(color: .primary.opacity(0.1), radius: 2, x: -1, y: -1)
                                .overlay(
                                    Text("삭제")
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                )
                        }
                    }
                    .transition(.move(edge: .trailing))
                }
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 10)
        .overlay(
            Divider().padding(.horizontal)
            , alignment: .bottom
        )
    }
}

struct Card_Previews: PreviewProvider {
    
    static let data = Category(name: "사과", category: "음식", expiration: Date())
    
    static var previews: some View {
        Card(edit: .constant(true), data: Product(), test: data)
    }
}
