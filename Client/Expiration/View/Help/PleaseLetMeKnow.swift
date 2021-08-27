//
//  PleaseLetMeKnow.swift.swift
//  PleaseLetMeKnow.swift
//
//  Created by 조종운 on 2021/08/22.
//

import SwiftUI

struct PleaseLetMeKnow: View {
    
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
                
                Text("필요하신 기능이 있으신가요?")
                    .font(.title)
                    .fontWeight(.heavy)
                    .padding(.bottom, 1)
                
                Text("건의사항 섹션을 통해 필요하신 기능을 알려주세요.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 30)
                
                VStack(alignment: .leading) {
                    Text("1. 메인 화면에서 좌측 상단 메뉴버튼을 눌러주세요.")
                        .font(.headline)
                    
                    Image("HelpCategory")
                        .resizable()
                        .scaledToFit()
                        .shadow(radius: 2)
                }
                .padding(.bottom, 30)
                
                VStack(alignment: .leading) {
                    Text("2. 메뉴화면에서 설정버튼을 눌러주세요.")
                        .font(.headline)
                    
                    Image("HelpSettingBtn")
                        .resizable()
                        .scaledToFit()
                        .shadow(radius: 2)
                }
                .padding(.bottom, 30)
                
                VStack(alignment: .leading) {
                    Text("3. 설정화면에서 개선사항 섹션의 버튼을 눌러주세요.")
                        .font(.headline)
                    
                    Image("HelpRequestNav")
                        .resizable()
                        .scaledToFit()
                        .shadow(radius: 2)
                }
                .padding(.bottom, 30)
                
                VStack(alignment: .leading) {
                    Text("4. 하얀색 공백에 원하시는 기능을 적어주세요")
                        .font(.headline)
                    
                    Image("HelpRequest")
                        .resizable()
                        .scaledToFit()
                        .shadow(radius: 2)
                }
                .padding(.bottom, 30)
                
                
                VStack(alignment: .leading) {
                    Text("5. 최하단의 제출버튼을 눌러 건의사항을 보내주세요.")
                        .font(.headline)
                }
                .padding(.bottom, 30)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()

        }
    }
}

struct PleaseLetMeKnow_Previews: PreviewProvider {
    static var previews: some View {
        PleaseLetMeKnow(isHelp: .constant(false))
    }
}
