//
//  Login.swift
//  Expiration
//
//  Created by 조종운 on 2021/07/01.
//

import SwiftUI

struct Login: View {
    
    let generator = UINotificationFeedbackGenerator()
    
    @EnvironmentObject var appModel: AppModel
    
    @State private var email = ""
    @State private var password = ""
    
    @State private var isAlert = false
    @State private var alertMsg = ""
    
    var body: some View {
        ZStack {
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
                            .font(.callout)
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
        }
        .navigationBarTitle("유통기한 관리사")
        .alert(isPresented: $isAlert) {
            Alert(
                title: Text("로그인에 문제가 생겼어요!"),
                message: Text("\(alertMsg)"),
                dismissButton: .default(Text("알겠어요."))
            )
        }

    }
    
    func handleLogin() {
        AccountApi().login(email, password) { status, email, name, msg in
            if (status) {
                CategoryApi().getCategoryList(email) { categoryList in
                    DispatchQueue.main.async {
                        appModel.email = email
                        appModel.name = name
                        appModel.categoryList = categoryList
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
}

struct Login_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            Login()
        }.environmentObject(AppModel())
    }
}
