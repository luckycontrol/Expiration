//
//  DeleteAccountSetting.swift
//  DeleteAccountSetting
//
//  Created by 조종운 on 2021/08/28.
//

import SwiftUI

struct DeleteAccountSetting: View {
    
    @State private var isToggle: Bool = false
    
    @State private var text: String = ""
    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("계정을 \n삭제하실껀가요?")
                        
                        Toggle("", isOn: $isToggle)
                    }
                    
                    if isToggle {
                        VStack(alignment: .leading) {
                            Text("이 앱의 아쉬운점을 알려주실 수 있나요?")
                            
                            TextEditor(text: $text)
                                .frame(minHeight: 300)
                                .cornerRadius(10)
                                .shadow(radius: 1)
                        }
                        .padding(.top, 30)
                        .transition(.move(edge: .bottom))
                        .animation(.easeIn(duration: 0.2))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
            .padding(.bottom, 80)
            
            if isToggle {
                VStack {
                    Spacer()
                    
                    Button(action: {}) {
                        Text("계정 삭제")
                            .foregroundColor(.white)
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.black)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                            .padding()
                    }
                }
                .transition(.move(edge: .trailing))
                .animation(.easeIn(duration: 0.2))
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("계정 삭제")
    }
}

struct DeleteAccountSetting_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DeleteAccountSetting()
        }
    }
}
