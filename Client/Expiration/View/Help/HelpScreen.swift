//
//  HelpScreen.swift
//  HelpScreen
//
//  Created by 조종운 on 2021/08/22.
//

import SwiftUI

struct HelpScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var currentTap: Int = 0
    
    @Binding var isHelp: Bool
    
    var body: some View {
        TabView(selection: $currentTap) {
            IntroduceThisApp(isHelp: $isHelp)
                .tag(0)
            
            HowToAddProduct(isHelp: $isHelp)
                .tag(1)
            
            HowToAddCategory(isHelp: $isHelp)
                .tag(2)
            
            HowToSetAlertTime(isHelp: $isHelp)
                .tag(3)
            
            PleaseLetMeKnow(isHelp: $isHelp)
                .tag(4)
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

struct HelpScreen_Previews: PreviewProvider {
    static var previews: some View {
        HelpScreen(isHelp: .constant(false))
    }
}
