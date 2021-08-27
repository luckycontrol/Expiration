//
//  AlarmSetting.swift
//  AlarmSetting
//
//  Created by 조종운 on 2021/08/21.
//

import SwiftUI

struct Setting: View {
    
    var body: some View {
        List {
            Section(header: Text("알람 설정")) {
                NavigationLink(destination: AlarmSetting()) {
                    Text("매일 몇 시에 알람을 드릴까요?")
                }
            }
            
            Section(header: Text("계정 설정")) {
                NavigationLink(destination: Text("HELLO")) {
                    Text("비밀번호 변경")
                }
                
                NavigationLink(destination: Text("HELLO")) {
                    Text("계정 삭제")
                }
            }
            
            Section(header: Text("건의 사항")) {
                NavigationLink(destination: UserRequest()) {
                    Text("이 부분 개선해주세요!")
                }
            }
        }
        .navigationTitle("설정")
    }
}

struct Setting_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Setting()
        }
    }
}
