//
//  ChangePasswordSetting.swift
//  ChangePasswordSetting
//
//  Created by 조종운 on 2021/08/28.
//

import SwiftUI

struct ChangePasswordSetting: View {
    
    @State private var newPassword: String = ""
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("새로운 비밀번호")
                    .foregroundColor(.secondary)
                    .padding(.bottom, 15)
                
                TextField("입력해주세요.", text: $newPassword)
                    .frame(height: 50)
                Divider()
            }
            
            Spacer()
            
            Button(action: {}) {
                Text("비밀번호 변경")
                    .foregroundColor(.white)
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.black)
                    .cornerRadius(10)
                    .shadow(radius: 3)
            }
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("비밀번호 변경")
    }
}

struct ChangePasswordSetting_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChangePasswordSetting()
        }
    }
}
