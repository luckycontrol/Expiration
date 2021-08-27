//
//  IntroduceThisApp.swift
//  IntroduceThisApp
//
//  Created by 조종운 on 2021/08/22.
//

import SwiftUI

struct IntroduceThisApp: View {
    
    @Binding var isHelp: Bool
    
    var body: some View {
        VStack {
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
            .padding()
            
            Spacer()
            
            Text("안녕하세요. \n이 앱을 소개해드릴게요!")
                .multilineTextAlignment(.center)
                .font(.title)
                .padding(.bottom)
            
            Text("이 앱은 유통기한을 확인하고자 만들었어요.")
                .padding(.bottom)
            
            Text("냉장고 내의 식품의 유통기한을 확인하고자 만들었지만, 무엇이든 상관없어요!")
                .multilineTextAlignment(.center)
            
            Spacer()
        }
    }
}

struct IntroduceThisApp_Previews: PreviewProvider {
    static var previews: some View {
        IntroduceThisApp(isHelp: .constant(false))
    }
}
