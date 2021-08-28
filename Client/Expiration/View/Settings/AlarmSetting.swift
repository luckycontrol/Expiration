//
//  AlarmSetting.swift
//  AlarmSetting
//
//  Created by 조종운 on 2021/08/21.
//

import SwiftUI

struct AlarmSetting: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var appModel: AppModel
    
    let screenWidth = UIScreen.main.bounds.width
    
    @State private var alertDate: Date = Date()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("매일 특정 시간마다 알람을 드려요.")
                .font(.title2)
            Text("유통기한에 임박한 품목이 없을 땐 알람이 가지 않아요!")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.top, 1)
            
            DatePicker("", selection: $alertDate, displayedComponents: .hourAndMinute)
            
            Spacer()
            
            Button(action: {
                setAlarm()
            }) {
                Text("알람 설정")
                    .foregroundColor(.white)
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.black)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("알람 설정")
    }

    
    func setAlarm() {
        let email = appModel.email
        let token = UserDefaults.standard.string(forKey: "fcmToken")!
        
        FCMApi().requestFCM(email, token) { status in
            
        }
    }
}

struct AlarmSetting_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AlarmSetting()
                .environmentObject(AppModel())
        }
    }
}
