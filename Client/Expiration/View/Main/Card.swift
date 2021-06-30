//
//  Card.swift
//  Expiration
//
//  Created by 조종운 on 2021/05/12.
//

import SwiftUI

struct Card: View {
    
    let product: ResponseReadProduct
    
    @Binding var edit: Bool
    
    @State private var offset: CGSize = .zero
    
    var formatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        return dateFormatter
    }()
    
    var body: some View {
        HStack {
            if let imageData = Data(base64Encoded: product.productImage) {
                if let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: 50, height: 50)
                }
            }
            
            VStack(alignment: .leading) {
                HStack(spacing: 12) {
                    Text(product.productName)
                        .font(.body)
                        .fontWeight(.medium)
                    
                    Image("유통기한 일주일남음")
                        .resizable()
                        .frame(width: 15, height: 15)
                }
                
                Text(product.expiration)
                    .font(.body)
                    .fontWeight(.regular)
            }
            
            Spacer()
            
            HStack {
                Button(action: {}) {
                    Text("수정")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.yellow)
                }
                
                Button(action: {}) {
                    Text("수정")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.red)
                }
            }
            .offset(x: 150)
        }
        .padding(15)
        .offset(x: edit ? -150 : 0)
    }
    
//    func onChanged(value: DragGesture.Value) {
//        if value.translation.width < 0 {
//            offset.width = value.translation.width
//        }
//
//        if isEdit && value.translation.width > 0 {
//
//
//            withAnimation(.easeIn(duration: 0.3)) {
//                offset.width = 0
//            }
//        }
//    }
//
//    func onEnded(value: DragGesture.Value) {
//        if offset.width <= -150 {
//
//
//            withAnimation(.easeIn(duration: 0.3)) {
//                offset.width = -UIScreen.main.bounds.width * 0.5
//            }
//        }
//    }
}

struct Card_Previews: PreviewProvider {
    
    static let product = ResponseReadProduct(_id: "", productCategory: "asdf", productName: "asdf", productImage: "", expiration: "asdf")
    
    static var previews: some View {
        Card(product: product, edit: .constant(false))
    }
}
