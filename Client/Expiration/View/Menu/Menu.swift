//
//  Menu.swift
//  Expiration
//
//  Created by 조종운 on 2021/05/12.
//

import SwiftUI

struct Menu: View {
    
    @EnvironmentObject var appModel: AppModel
    let generator = UIImpactFeedbackGenerator(style: .medium)
    
    @State private var isEdit = false
    
    @State private var offset: CGSize = .zero
    
    // 메뉴
    @Binding var menu: Bool
    
    // 카테고리
    @Binding var isAppendCategory: Bool
    @Binding var isRemoveCategory: Bool
    @Binding var selectedRemoveCategory: String
    
    // 알림 설정
    @Binding var isSetting: Bool
    
    // 로그아웃
    @Binding var isLogout: Bool
    
    var body: some View {
        ZStack {
            Color("MenuColor").ignoresSafeArea()
        
            // 메뉴
            HStack {
                ScrollView(.vertical, showsIndicators: false) {
        
                    // MARK: 메뉴 종료 버튼
                    HStack {
                        Button(action: {
                            withAnimation {
                                UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                                menu = false
                            }
                        }) {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                        }
        
                        Spacer()
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
                            HStack {
                                Text("카테고리")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
        
                                Spacer()
        
                                Button(action: {
                                    generator.impactOccurred()
                                    isEdit.toggle()
                                }) {
                                    Text("편집")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 5)
                                        .background(isEdit ? Color.black.opacity(0.4) : nil)
                                        .cornerRadius(10)
                                }
                            }
                            .frame(width: 150, height: 30)
        
                            VStack(alignment: .leading, spacing: 5) {
                                ForEach(appModel.categoryList, id: \.self) { category in
                                    Button(action: {
                                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                                        appModel.isLoading = true
                                        appModel.selectedCategory = category
                                        handleSelectCategoryAndChangeProductList(category)
                                    }) {
                                        HStack {
                                            Text(category)
                                                .fontWeight(.medium)
                                                .foregroundColor(.white)
        
                                            Spacer()
        
                                            if (isEdit) {
                                                Button(action: {
                                                    selectedRemoveCategory = category
                                                    isRemoveCategory = true
                                                }) {
                                                    Image(systemName: "xmark")
                                                        .foregroundColor(.white)
                                                }
                                            }
                                        }
                                        .padding()
                                        .frame(width: 150, height: 40)
                                        .background(appModel.selectedCategory == category ? Color.black.opacity(0.4) : nil)
                                        .cornerRadius(10)
                                    }
                                }
        
                                Button(action: {
                                    withAnimation {
                                        isAppendCategory = true
                                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                                    }
                                }) {
                                    Text("카테고리 추가")
                                }
                                .foregroundColor(.white)
                                .padding(.top, 8)
                            }
                            .padding(.top, 5)
                            .padding(.leading, 10)
        
                            VStack(alignment: .leading, spacing: 12) {
                                Button(action: {
                                    menu = false
                                    isSetting = true
                                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                                }) {
                                    Text("설정")
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                }
                                
                                Button(action: { isLogout = true }) {
                                    Text("로그아웃")
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                }
                            }
                            .padding(.top, 50)
                        }
        
                        Spacer()
                    }
                    .padding(.top, 30)
                    .padding(.bottom, 60)
                    .padding(.horizontal)
                }
            }
        }
    }
    
    // MARK: 카테고리 변경 후 product 리스트 내용 변경 함수
    func handleSelectCategoryAndChangeProductList(_ categoryName: String) {
        ProductApi().getProductList(appModel.email, categoryName) { productList in
            DispatchQueue.main.async {
                appModel.productList = productList
                appModel.isLoading = false
            }
        }
    }
}

struct Menu_Previews: PreviewProvider {
    
    static var previews: some View {
        Menu(
            menu: .constant(false),
            isAppendCategory: .constant(false),
            isRemoveCategory: .constant(false),
            selectedRemoveCategory: .constant(""),
            isSetting: .constant(false),
            isLogout: .constant(false)
        )
        .environmentObject(AppModel())
    }
}

