//
//  Login.swift
//  Expiration
//
//  Created by 조종운 on 2021/07/01.
//

import SwiftUI

struct Login: View {
    
    @State private var email = ""
    @State private var password = ""
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().tintColor = .white
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("First"), Color("Second")], startPoint: .topLeading, endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
                
            
            VStack {
                VStack(alignment: .leading) {
                    Text("이메일")
                        .font(.headline)
                    
                    TextField("", text: $email)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                    Divider().frame(height: 2).background(Color.white)
                }
                .foregroundColor(.white)
                .padding(.top, 35)
                
                VStack(alignment: .leading) {
                    Text("비밀번호")
                        .font(.headline)
                    
                    SecureField("", text: $password)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                    Divider().frame(height: 2).background(Color.white)
                }
                .foregroundColor(.white)
                .padding(.top, 25)
                
                VStack(spacing: 15) {
                    Text("계정이 없으신가요?")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    NavigationLink(destination: CreateAccount()) {
                        Text("계정 만들기")
                            .font(.callout)
                            .foregroundColor(.white)
                    }
                    
//                    Button(action: {}) {
//                        VStack(spacing: 8) {
//                            Image(systemName: "applelogo")
//                                .font(.title)
//
//                            Text("애플 계정으로 로그인")
//                                .font(.headline)
//                        }
//                        .foregroundColor(.white)
//                    }
//                    .padding(.top, 25)
                }
                .padding(.top, 35)
                
                Spacer()
                
                Button(action: {}) {
                    Text("로그인")
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .font(.headline)
                        .foregroundColor(.black)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: .black.opacity(0.4), radius: 3, x: 3, y: 3)
                }
            }
            .padding()
        }
        .navigationBarTitle("유통기한 관리사")
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Login()
        }
    }
}
