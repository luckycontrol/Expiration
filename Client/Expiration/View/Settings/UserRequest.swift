//
//  UserRequest.swift.swift
//  UserRequest.swift
//
//  Created by 조종운 on 2021/08/22.
//

import SwiftUI

struct UserRequest: View {
    
    @State private var text: String = ""
    
    var body: some View {
        ZStack {
            List {
                TextEditor(text: $text)
                    .frame(minHeight: 300)
            }
            .padding(.bottom, 55)
            
            VStack {
                Spacer()
                
                Button(action: {}) {
                    Text("제출")
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.black)
                .cornerRadius(10)
                .padding()
            }
        }
        .navigationTitle("건의사항")
    }
}

struct UserRequest_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UserRequest()
        }
    }
}
