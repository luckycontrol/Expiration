//
//  LoadingView.swift
//  LoadingView
//
//  Created by 조종운 on 2021/08/19.
//

import SwiftUI

struct LoadingView: View {
    
    @State private var isStart: Bool = false
    
    @State private var isDelay: Bool = false
    
    var body: some View {
        Rectangle()
            .overlay(
                VStack {
                    Image("LoadingWheel")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .rotationEffect(Angle(degrees: isStart ? 360 : 0))
                        .animation(.linear(duration: 1).repeatForever(autoreverses: false))
                        .onAppear {
                            isStart = true
                        }
                    
                    Text("시간이 조금 소요될 수 있어요!")
                        .foregroundColor(isDelay ? .black : .clear)
                        .padding(.top)
                }
            )
            .foregroundColor(.white)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
                    isDelay = true
                }
            }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
