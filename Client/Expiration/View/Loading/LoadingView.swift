//
//  LoadingView.swift
//  LoadingView
//
//  Created by 조종운 on 2021/08/19.
//

import SwiftUI

struct LoadingView: View {
    
    @State private var isStart: Bool = false
    
    var body: some View {
        Image("LoadingWheel")
            .resizable()
            .frame(width: 30, height: 30)
            .rotationEffect(Angle(degrees: isStart ? 360 : 0))
            .animation(.linear(duration: 1).repeatForever(autoreverses: false))
            .onAppear {
                isStart = true
            }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
