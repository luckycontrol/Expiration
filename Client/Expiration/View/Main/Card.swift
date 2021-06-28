//
//  Card.swift
//  Expiration
//
//  Created by 조종운 on 2021/05/12.
//

import SwiftUI

struct Card: View {
    
    @Binding var edit: Bool

    @State private var isEdit = false
    @State private var offset: CGSize = .zero
    
    var formatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        return dateFormatter
    }()
    
    var body: some View {
        ZStack {
            
            Color("MenuColor").edgesIgnoringSafeArea(.all)
            
            HStack(spacing: 20) {
                Spacer()
                
                Button(action: {}) {
                    Text("편집")
                        .foregroundColor(.yellow)
                        .font(.body)
                        .fontWeight(.medium)
                }
                
                Button(action: {}) {
                    Text("삭제")
                        .foregroundColor(.red)
                        .font(.body)
                        .fontWeight(.medium)
                }
            }
            .padding(.horizontal)
            
            HStack {
                Image("test")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .aspectRatio(contentMode: .fit)

                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("사과")
                            .font(.body)
                            .fontWeight(.medium)

                        Image("유통기한 일주일남음")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .aspectRatio(contentMode: .fit)
                    }

                    Text("2021-05-29")
                        .font(.body)
                        .fontWeight(.medium)
                }
                
                Spacer()
            }
            .frame(height: 70)
            .padding(.horizontal, 8)
            .background(Color.white)
            .offset(offset)
            .gesture(
                DragGesture()
                    .onChanged(onChanged)
                    .onEnded(onEnded)
            )
            .overlay(
                Divider().padding(.horizontal, 8), alignment: .bottom
            )
        }
    }
    
    func onChanged(value: DragGesture.Value) {
        if value.translation.width < 0 {
            offset.width = value.translation.width
        }
        
        if isEdit && value.translation.width > 0 {
            isEdit = false
            
            withAnimation(.easeIn(duration: 0.3)) {
                offset.width = 0
            }
        }
    }
    
    func onEnded(value: DragGesture.Value) {
        if offset.width <= -150 {
            isEdit = true
            
            withAnimation(.easeIn(duration: 0.3)) {
                offset.width = -UIScreen.main.bounds.width * 0.5
            }
        }
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card(edit: .constant(true))
    }
}
