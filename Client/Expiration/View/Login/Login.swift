//
//  Login.swift
//  Expiration
//
//  Created by 조종운 on 2021/07/01.
//

import SwiftUI

struct Login: View {
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: LoginState.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \LoginState.id, ascending: true)
        ],
        animation: .default
    )
    
    private var loginState: FetchedResults<LoginState>
    
    let generator = UINotificationFeedbackGenerator()
    let impactGenerator = UIImpactFeedbackGenerator(style: .heavy)
    
    @EnvironmentObject var appModel: AppModel
    
    @State private var email = ""
    @State private var password = ""
    
    @State private var isAlert = false
    @State private var alertMsg = ""
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading) {
                    Text("이메일")
                        .font(.headline)
                    
                    TextField("", text: $email)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                    Divider().frame(height: 2).background(Color.white)
                }
                .padding(.top, 35)
                
                VStack(alignment: .leading) {
                    Text("비밀번호")
                        .font(.headline)
                    
                    SecureField("", text: $password)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                    Divider().frame(height: 2).background(Color.white)
                }
                .padding(.top, 25)
                
                VStack(spacing: 15) {
                    Text("계정이 없으신가요?")
                        .font(.headline)
                    
                    NavigationLink(destination: CreateAccount()) {
                        Text("계정 만들기")
                    }
                }
                .padding(.top, 35)
                
                Spacer()
                
                Button(action: handleLogin) {
                    Text("로그인")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.black)
                        .cornerRadius(10)
                        .shadow(color: .black, radius: 0.2, x: 2, y: 2)
                }
            }
            .padding(20)
            .navigationBarTitle("유통기한 관리사")
            .navigationBarTitleDisplayMode(.large)
            .alert(isPresented: $isAlert) {
                Alert(
                    title: Text("로그인에 문제가 생겼어요!"),
                    message: Text("\(alertMsg)"),
                    dismissButton: .default(Text("알겠어요."))
                )
            }
            .onAppear {
                if (loginState.count >= 1) {
                    CategoryApi().getCategoryList(loginState[0].email!) { categoryList in
                        DispatchQueue.main.async {
                            appModel.email = loginState[0].email!
                            appModel.name = loginState[0].name!
                            appModel.categoryList = categoryList
                            appModel.selectedCateogry = categoryList[0]
                            appModel.isLogin = true
                            generator.notificationOccurred(.success)
                        }
                    }
                }
            }
        }
    }
    
    func handleLogin() {
        AccountApi().login(email, password) { status, email, name, msg in
            if (status) {
                CategoryApi().getCategoryList(email) { categoryList in
                    
                    handleSetAutoLogin(email, name)
                    
                    DispatchQueue.main.async {
                        appModel.email = email
                        appModel.name = name
                        appModel.categoryList = categoryList
                        appModel.selectedCateogry = categoryList[0]
                        appModel.isLogin = true
                        generator.notificationOccurred(.success)
                    }
                }
            } else {
                isAlert = true
                alertMsg = msg
            }
        }
    }
    
    func handleSetAutoLogin(_ email: String, _ name: String) {
        if (loginState.count >= 1) {
            loginState[0].email = email
            loginState[0].name = name
            
        } else {
            let newState = LoginState(context: viewContext)
            newState.id = 0
            newState.email = email
            newState.name = name
        }

        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct Login_Previews: PreviewProvider {
    
    static var previews: some View {
        Login()
            .environmentObject(AppModel())
    }
}
