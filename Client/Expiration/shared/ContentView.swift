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
        NavigationView {
            if appModel.isLogin { MainView() }
            else { Login() }
        }
        .environmentObject(appModel)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension UINavigationController {
    // Remove back button text
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
