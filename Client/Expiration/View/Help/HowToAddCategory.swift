//
//  HowToAddCategory.swift
//  HowToAddCategory
//
//  Created by 조종운 on 2021/08/22.
//

import SwiftUI

struct HowToAddCategory: View {
    
    @Binding var isHelp: Bool
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                HStack {
                    Button(action: {
                        isHelp = false
                    }) {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                }
                
                Text("카테고리 추가 방법")
                    .font(.title)
                    .fontWeight(.heavy)
                    .padding(.bottom)
                
                VStack(alignment: .leading) {
                    Text("1. 메인 화면에서 좌측 상단 버튼을 클릭해주세요!")
                        .font(.headline)
                    Image("HelpCategory")
                        .resizable()
                        .scaledToFit()
                        .shadow(radius: 2)
                }
                .padding(.bottom, 30)
                
                VStack(alignment: .leading) {
                    Text("2. 메뉴 화면에서 '카테고리 추가' 버튼을 눌러주세요.")
                        .font(.headline)
                    
                    Image("HelpAddCategory")
                        .resizable()
                        .scaledToFit()
                        .shadow(radius: 2)
                }
                .padding(.bottom, 30)
                
                VStack(alignment: .leading) {
                    Text("3. 원하시는 카테고리 이름을 입력해주세요.")
                        .font(.headline)
                    
                    Image("HelpCategoryInput")
                        .resizable()
                        .scaledToFit()
                        .shadow(radius: 2)
                    
                    Image("HelpCategoryInputPlus")
                        .resizable()
                        .scaledToFit()
                        .shadow(radius: 2)
                }
                .padding(.bottom, 30)
                
                VStack(alignment: .leading) {
                    Text("4. 추가버튼을 누르시면 잠시후 카테고리가 추가된 것을 확신하실 수 있어요!")
                        .font(.headline)
                    
                    Image("HelpAddCategoryComplete")
                        .resizable()
                        .scaledToFit()
                        .shadow(radius: 2)
                }
                .padding(.bottom, 30)
            }
            .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
            .padding()
        }
    }
}

struct HowToAddCategory_Previews: PreviewProvider {
    static var previews: some View {
        HowToAddCategory(isHelp: .constant(false))
    }
}
