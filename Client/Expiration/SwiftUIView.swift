//
//  SwiftUIView.swift
//  SwiftUIView
//
//  Created by 조종운 on 2021/07/26.
//

import SwiftUI

struct SwiftUIView: View {
    
    @State var test = ["apple", "banana", "kiwi", "mango"]
    
    var body: some View {
        List {
            ForEach(test, id: \.self) { fruit in
                Text(fruit)
            }
            .onDelete(perform: onDelete)
        }
        
    }
    
    func onDelete (at offsets: IndexSet) {
        test.remove(atOffsets: offsets)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
