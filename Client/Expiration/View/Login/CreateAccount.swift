//
//  CreateAccount.swift
//  Expiration
//
//  Created by 조종운 on 2021/07/01.
//

import SwiftUI

struct CreateAccount: View {
    
    @State private var email = ""
    @State private var password = ""
    
    @State private var alertMessage = ""
    @State private var isAlert = false
    
    var body: some View {
        ZStack {
            VStack {
                Text("무엇이든 놓치지않도록. \n 유통기한을 관리해보세요.")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .lineSpacing(10)
                    .padding(.top, 35)
                
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
                
                Spacer()
                
                Button(action: {
                    checkValidInput()
                }) {
                    Text("계정 생성")
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .font(.headline)
                        .foregroundColor(.black)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: .black.opacity(0.4), radius: 2, x: 1, y: 3)
                }
            }
            .padding()
        }
        .navigationBarTitle("계정 만들기")
        .alert(isPresented: $isAlert) {
            Alert(title: Text("알림"), message: Text(alertMessage), dismissButton: .default(Text("확인")))
        }
    }
    
    func checkValidInput() {
        if email == "" || password == "" {
            isAlert = true
            alertMessage = "이메일과 비밀번호를 입력해주세요."
        }
    }
    
    func checkEmailPassword() {
        
    }
}

struct CreateAccount_Previews: PreviewProvider {
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = appearance
    }
    
    static var previews: some View {
        NavigationView {
            CreateAccount()
        }
    }
}
