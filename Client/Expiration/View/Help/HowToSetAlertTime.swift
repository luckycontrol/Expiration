//
//  HowToSetAlertTime.swift
//  HowToSetAlertTime
//
//  Created by 조종운 on 2021/08/22.
//

import SwiftUI

struct HowToSetAlertTime: View {
    
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
                
                Text("알람 설정 하는법")
                    .font(.title)
                    .fontWeight(.heavy)
                    .padding(.bottom)
                
                Text("매일 하루 한 번 설정하신 시간에 알람이 울려요.")
                    .foregroundColor(.secondary)
                    .padding(.bottom, 30)
                
                VStack(alignment: .leading) {
                    Text("1. 메인화면 좌측 상단에 메뉴버튼을 눌러주세요.")
                        .font(.headline)
                    Image("HelpCategory")
                        .resizable()
                        .scaledToFit()
                        .shadow(radius: 2)
                }
                .padding(.bottom, 30)
                
                VStack(alignment: .leading) {
                    Text("2. 메뉴화면 하단의 설정버튼을 눌러주세요.")
                        .font(.headline)
                    Image("HelpSettingBtn")
                        .resizable()
                        .scaledToFit()
                        .shadow(radius: 2)
                }
                .padding(.bottom, 30)
                
                VStack(alignment: .leading) {
                    Text("3. 맨 위의 알람설정 섹션의 버튼을 눌러주세요.")
                        .font(.headline)
                    Image("HelpAlarmNav")
                        .resizable()
                        .scaledToFit()
                        .shadow(radius: 2)
                }
                .padding(.bottom, 30)
                
                VStack(alignment: .leading) {
                    Text("4. 시간이 출력된 부분을 클릭하고, 원하시는 시간을 선택하세요.")
                        .font(.headline)
                    Image("HelpClickCalendar")
                        .resizable()
                        .scaledToFit()
                        .shadow(radius: 2)
                    
                    Image("HelpSetTime")
                        .resizable()
                        .scaledToFit()
                        .shadow(radius: 2)
                }
                .padding(.bottom, 30)
                
                VStack(alignment: .leading) {
                    Text("5. 알람 설정버튼을 누르시면 매일 원하시는 시간에 알람이 울리게돼요.")
                        .font(.headline)
                        .padding(.bottom)
                    Text("유통기한이 임박한 ( 1 ~ 3일 ) 품목이 없을 경우 알람이 울리지 않아요.")
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                }
                .padding(.bottom, 30)

            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
    }
}

struct HowToSetAlertTime_Previews: PreviewProvider {
    static var previews: some View {
        HowToSetAlertTime(isHelp: .constant(false))
    }
}
