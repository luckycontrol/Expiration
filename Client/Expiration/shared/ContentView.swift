//
//  ContentView.swift
//  Expiration
//
//  Created by 조종운 on 2021/05/12.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @StateObject var appModel = AppModel()
    
    init() {
        UINavigationBar.appearance().tintColor = .black
    }

    var body: some View {
//        NavigationView {
//            if appModel.isLogin { MainView() }
//            else { Login() }
//        }
//        .environmentObject(appModel)
        NavigationView {
            MainView()
        }
        .environmentObject(appModel)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
