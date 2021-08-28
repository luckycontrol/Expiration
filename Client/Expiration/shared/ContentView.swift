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
    
    @State private var isLoading = false
    
    init() {
        UINavigationBar.appearance().tintColor = .black
    }

    var body: some View {
        Group {
            if isLoading {
                LoadingView()
            } else {
                if appModel.isLogin {
                    MainView()
                } else {
                    Login()
                }
            }
        }
        .onAppear {
            if let email = UserDefaults.standard.string(forKey: "email"), let name = UserDefaults.standard.string(forKey: "name") {
                isLoading = true
                appModel.email = email
                appModel.name = name
                
                CategoryApi().getCategoryList(email) { categoryList in
                    DispatchQueue.main.async {
                        appModel.categoryList = categoryList
                        appModel.selectedCategory = categoryList[0]
                        
                        isLoading = false
                        appModel.isLogin = true
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                    }
                }
            }
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
