//
//  TestView.swift.swift
//  TestView.swift
//
//  Created by 조종운 on 2021/08/27.
//

import SwiftUI

struct TestView_swift: View {
    
    @State private var categoryList = [String]()
    
    var body: some View {
        VStack {
            Text("\(categoryList.count)")
        }
        .onAppear {
            CategoryApi().getCategoryList("test@email.com") { categoryList in
                DispatchQueue.main.async {
                    self.categoryList = categoryList
                }
            }
        }
    }
}

struct TestView_swift_Previews: PreviewProvider {
    static var previews: some View {
        TestView_swift()
    }
}
