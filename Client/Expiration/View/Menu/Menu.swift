//
//  Menu.swift
//  Expiration
//
//  Created by 조종운 on 2021/05/12.
//

import SwiftUI

struct Menu: View {
    
    let categorys = ["음식", "생활용품"]
    
    @ObservedObject var appModel: AppModel
    
    @Binding var menu: Bool
    
    @State private var offset: CGSize = .zero
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                VStack(spacing: 0) {
                    
                    // MARK: 메뉴 종료 버튼
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            menu = false
                        }) {
                            Image(systemName: "chevron.right.circle.fill")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal)
                    
                    // MARK: 앱 이름, 디바이더
                    VStack(spacing: 5) {
                        HStack {
                            Text("유통기한 관리사")
                                .font(.title)
                                .fontWeight(.black)
                                .foregroundColor(.white)
                            
                            Spacer()
                        }
                        
                        Divider()
                            .frame(height: 5)
                            .background(Color.white)
                    }
                    .padding(.top, 15)
                    .padding(.horizontal)
                    
                    // MARK: 카테고리, 카테고리 추가
                    HStack {
                        VStack(alignment: .leading) {
                            Text("카테고리")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)

                            VStack(alignment: .leading, spacing: 5) {
                                ForEach(categorys, id: \.self) { category in
                                    Button(action: {
                                        appModel.selectedCateogry = category
                                        menu = false
                                    }) {
                                        Text(category)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                    }
                                }
                                
                                Button(action: {}) {
                                    Text("카테고리 추가")
                                }
                                .foregroundColor(.white)
                                .padding(.top, 8)
                            }
                            .padding(.top, 5)
                            .padding(.leading, 10)
                        }
                        
                        Spacer()
                    }
                    .padding(.top, 30)
                    .padding(.bottom, 60)
                    .padding(.horizontal)
                    
                    // MARK: 디바이더, 관리항목 추가
                    VStack(alignment: .leading) {
                        Divider()
                            .frame(height: 5)
                            .background(Color.white)
                        
                        Button(action: {}) {
                            Text("관리항목 추가")
                                .fontWeight(.bold)
                        }
                        .foregroundColor(.white)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .frame(width: geometry.frame(in: .global).width * 0.75, height: geometry.frame(in: .global).height)
                .background(Color("MenuColor").edgesIgnoringSafeArea(.vertical))
                
                Spacer()
            }
            .frame(width: geometry.frame(in: .global).width, height: geometry.frame(in: .global).height)
            .shadow(color: Color("MenuColor"), radius: 10, x: 5, y: 5)
        }
        .offset(offset)
        .gesture(
            DragGesture()
                .onChanged(onChanged)
                .onEnded(onEnded)
        )
        .transition(.move(edge: .leading))
        .animation(.linear(duration: 0.15))
    }
    
    func onChanged(value: DragGesture.Value) {
        if offset.width <= 0 {
            offset.width = value.translation.width
        }
    }
    
    func onEnded(value: DragGesture.Value) {
        if offset.width <= -150 {
            menu = false
        }
        offset = .zero
    }
}

struct Menu_Previews: PreviewProvider {
    
    static let appModel = AppModel()
    
    static var previews: some View {
        Menu(appModel: appModel, menu: .constant(false))
    }
}
