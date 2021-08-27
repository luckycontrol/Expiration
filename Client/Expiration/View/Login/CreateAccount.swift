//
//  CreateAccount.swift
//  Expiration
//
//  Created by 조종운 on 2021/07/01.
//

import SwiftUI

struct CreateAccount: View {
    
    @Environment(\.presentationMode) var presentationMode
    let generator = UINotificationFeedbackGenerator()
    
    @State private var email = ""
    @State private var name = ""
    @State private var password = ""
    
    @State private var alertMessage = ""
    @State private var isAlert = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("다른 곳에서 사용하시지 않는")
                Text("간단한 아이디와 비밀번호로 계정을 만들어주세요.")
            }
            .foregroundColor(.secondary)
            
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
                Text("이름")
                    .font(.headline)
                
                TextField("", text: $name)
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
                if (checkValidInput()) {
                    AccountApi().checkDuplicate(email) { status in
                        if (status) {
                            alertMessage = "입력하신 이메일이 이미 존재합니다!"
                            isAlert = true
                        } else {
                            AccountApi().createAccount(email, name, password) { status in
                                if (status) {
                                    CategoryApi().createCategoryListWhenCreateAccount(email) { status in
                                        if (status) {
                                            DispatchQueue.main.async {
                                                generator.notificationOccurred(.success)
                                                presentationMode.wrappedValue.dismiss()
                                            }
                                        } else {
                                            alertMessage = "계정을 생성하지 못했어요. 다시 시도해주세요!"
                                            isAlert = true
                                        }
                                    }
                                } else {
                                    alertMessage = "계정을 생성하지 못했어요. 다시 시도해주세요!"
                                    isAlert = true
                                }
                            }
                        }
                    }
                }
            }) {
                Text("계정 생성")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.black)
                    .cornerRadius(10)
                    .shadow(color: .black, radius: 2, x: 2, y: 2)
            }
        }
        .padding(20)
        .navigationBarTitle("계정 만들기")
        .alert(isPresented: $isAlert) {
            Alert(title: Text("회원가입에 문제가 생겼어요!"), message: Text(alertMessage), dismissButton: .default(Text("확인")))
        }
    }
    
    func checkValidInput() -> Bool {
        if email == "" || password == "" {
            isAlert = true
            alertMessage = "이메일과 비밀번호를 모두 입력해주세요."
            
            return false
        }
        
        return true
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
