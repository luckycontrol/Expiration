//
//  Practice.swift
//  Practice
//
//  Created by 조종운 on 2021/08/16.
//

import SwiftUI

struct Practice: View {
    
    @State private var path = ""
    @State private var image: UIImage?
    
    var body: some View {
        VStack {
            
            Text("\(path)")
            
            if (image != nil) {
                Image(uiImage: image!)
            }
            
            Button(action: {
                let image = UIImage(named: "LoginBackground")
                
                path = "\(saveImageInDocument(image!))"
                
            }) {
                Text("터치")
            }
        }
        .onAppear {
            FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        }
    }
}

struct Practice_Previews: PreviewProvider {
    static var previews: some View {
        Practice()
    }
}
