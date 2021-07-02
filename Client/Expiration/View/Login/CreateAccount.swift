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
    
    @State private var alertText = ""
    
    @State private var isAlert = false
    
    let alert = Alert(title: Text(""), message: Text(alertText), dismissButton: <#T##Alert.Button?#>)
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("First"), Color("Second")], startPoint: .topLeading, endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("무엇이든 놓치지않도록. \n 유통기한을 관리해보세요.")
                    .foregroundColor(.white)
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
                
                Spacer()
                
                Button(action: {}) {
                    Text("계정 생성")
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
        .navigationBarTitle("계정 만들기")
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
