//
//  Menu.swift
//  Expiration
//
//  Created by 조종운 on 2021/05/12.
//

import SwiftUI

struct Menu: View {
    
    @EnvironmentObject var appModel: AppModel
    
    @Binding var menu: Bool
    
    @State private var offset: CGSize = .zero
    
    @State private var createCategoryName = ""
    @State private var createCategoryModal = false
    
    @State private var createResultMsg = ""
    @State private var createResultState = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if (createCategoryModal) {
                    Color.black.opacity(0.5).edgesIgnoringSafeArea(.all).zIndex(10)
                }
                
                // 메뉴
                HStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        
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
                                Text("\(appModel.name) 님, 안녕하세요")
                                    .font(.title)
                                    .fontWeight(.black)
                                    .foregroundColor(.white)
                                
                                Spacer()
                            }
                            
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
                                    ForEach(appModel.categoryList, id: \.self) { category in
                                        Button(action: {
                                            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                                            appModel.selectedCateogry = category
                                            menu = false
                                        }) {
                                            Text(category)
                                                .font(.headline)
                                                .foregroundColor(.white)
                                        }
                                    }
                                    
                                    Button(action: {
                                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                                        createCategoryModal = true
                                    }) {
                                        Text("카테고리 추가")
                                    }
                                    .foregroundColor(.white)
                                    .padding(.top, 8)
                                }
                                .padding(.top, 5)
                                .padding(.leading, 10)
                                
                                Button(action: {}) {
                                    Text("로그아웃")
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                }
                                .padding(.top, 50)
                            }
                            
                            Spacer()
                        }
                        .padding(.top, 30)
                        .padding(.bottom, 60)
                        .padding(.horizontal)
                    }
                    .frame(width: geometry.frame(in: .global).width * 0.75, height: geometry.frame(in: .global).height)
                    .background(Color("MenuColor").edgesIgnoringSafeArea(.vertical))
                    
                    Spacer()
                }
                .frame(width: geometry.frame(in: .global).width, height: geometry.frame(in: .global).height)
                .shadow(color: Color("MenuColor"), radius: 0.22, x: 0.2, y: 0.2)
                
                // 메뉴추가 모달
                if (createCategoryModal) {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 300, height: 300)
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 0.5, x: 0.2, y: 0.2)
                        .overlay(
                            VStack {
                                HStack {
                                    Button(action: {
                                        createCategoryModal = false
                                        createResultMsg = ""
                                        createResultState = false
                                    }) {
                                        Image(systemName: "xmark")
                                            .foregroundColor(.black)
                                    }
                                    
                                    Spacer()
                                }
                                
                                if (createResultState) {
                                    Text("\(createResultMsg)")
                                        .multilineTextAlignment(.center)
                                        .font(.title3)
                                        .padding(.top, 15)
                                } else {
                                    Text("추가하실 카테고리 이름을 입력해주세요.")
                                        .multilineTextAlignment(.center)
                                        .font(.title3)
                                }
                                
                                Spacer()
                                
                                TextField("", text: $createCategoryName)
                                Divider()
                                
                                Spacer()
                                
                                Button(action: handleCreateNewCategory) {
                                    Text("추가")
                                        .foregroundColor(.white)
                                        .fontWeight(.semibold)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 40)
                                        .background(Color.black)
                                        .cornerRadius(10)
                                        .shadow(color: .black, radius: 0.2, x: 0.2, y: 0.2)
                                }
                            }
                            .padding(20)
                        )
                        .zIndex(11)
                        .transition(.move(edge: .bottom))
                }
            }
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
    
    func handleCreateNewCategory() {
        if (createCategoryName == "") {
            createResultMsg = "카테고리 이름을 입력해주세요!"
            createResultState = true
            return
        }
        
        CategoryApi().createNewCategory(appModel.email, createCategoryName) { status, msg, categoryName in
            if (!status) {
                createResultState = true
                createResultMsg = msg
                return
            }
            
            DispatchQueue.main.async {
                appModel.categoryList.append(categoryName)
            }
        }
    }
}

struct Menu_Previews: PreviewProvider {
    
    static var previews: some View {
        Menu(menu: .constant(false)).environmentObject(AppModel())
    }
}
