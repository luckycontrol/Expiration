//
//  HowToAddProduct.swift
//  HowToAddProduct
//
//  Created by 조종운 on 2021/08/22.
//

import SwiftUI

struct HowToAddProduct: View {
    
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
                
                Text("품목 추가 방법")
                    .font(.title)
                    .fontWeight(.heavy)
                    .padding(.bottom)
                
                VStack(alignment: .leading) {
                    Text("1. 우선 메인 화면에서 '+'버튼을 눌러요!")
                        .font(.headline)
                    Image("HelpAddButton")
                        .resizable()
                        .scaledToFit()
                        .shadow(radius: 2)
                }
                .padding(.bottom, 30)
                
                VStack(alignment: .leading) {
                    Text("2. 가운데 박스를 클릭해서 이미지를 추가해요.")
                        .font(.headline)
                    Text("이미지는 직접 촬영해서, \n혹은 앨범에서 선택해서 사용할 수 있어요.")
                        .padding([.leading, .bottom])
                    Text("이미지는 반드시 넣어주세요!")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Image("HelpAddImage")
                        .resizable()
                        .scaledToFit()
                        .shadow(radius: 2)
                }
                .padding(.bottom, 30)
                
                VStack(alignment: .leading) {
                    Text("3. 추가하신 품목의 이름과 유통기한을 입력하고 추가버튼을 눌러주세요.")
                        .font(.headline)
                    Image("HelpInput")
                        .resizable()
                        .scaledToFit()
                        .shadow(radius: 2)
                }
                .padding(.bottom, 30)
                
                VStack(alignment: .leading) {
                    Text("4. 정상적으로 추가되면 아래와같이 품목이 출력돼요!")
                        .font(.headline)
                    Image("HelpList")
                        .resizable()
                        .scaledToFit()
                        .shadow(radius: 2)
                }
                .padding(.bottom, 30)
                
                VStack(alignment: .leading) {
                    Text("5. 이름 옆의 마크는 다음을 의미해요!")
                        .font(.headline)
                    VStack(alignment: .leading) {
                        HStack {
                            Image("유통기한 일주일남음")
                                .resizable()
                                .frame(width: 20, height: 20)
                            
                            Text(": 유통기한이 일주일 이상 남은 상태에요.")
                        }
                        
                        HStack {
                            Image("유통기한 삼일남음")
                                .resizable()
                                .frame(width: 20, height: 20)
                            
                            Text(": 유통기한이 3 ~ 7일 남은 상태에요")
                        }
                        
                        HStack {
                            Image("유통기한 하루남음")
                                .resizable()
                                .frame(width: 20, height: 20)
                            
                            Text(": 유통기한이 1 ~ 3일 남은 상태에요.")
                        }
                        
                        HStack {
                            Image("유통기한 지남")
                                .resizable()
                                .frame(width: 20, height: 20)
                            
                            Text(": 유통기한이 지났음을 의미해요.")
                        }
                        Text("알람은 1 ~ 3일 남은 시기부터 울리기 시작해요.")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding(.bottom, 20)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct HowToAddProduct_Previews: PreviewProvider {
    static var previews: some View {
        HowToAddProduct(isHelp: .constant(false))
    }
}
