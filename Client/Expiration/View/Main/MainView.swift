//
//  MainView.swift
//  MainView
//
//  Created by 조종운 on 2021/08/15.
//

import SwiftUI

struct MainView: View {
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: LoginState.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \LoginState.id, ascending: true)
        ],
        animation: .default
    )
    
    private var loginState: FetchedResults<LoginState>
    
    @EnvironmentObject var appModel: AppModel
    
    @State private var menu = false
    
    // 카테고리
    @State private var isAppendCategory: Bool = false
    @State private var categoryName: String = ""
    @State private var appendResult: Bool = false
    @State private var appendResultMsg: String = ""
    
    // 로그아웃
    @State private var isLogout: Bool = false
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Menu(menu: $menu, isAppendCategory: $isAppendCategory, isLogout: $isLogout)
                
                ListView(menu: $menu)
                
                // - - - - - - - 모달 - - - - - -
                
                if (isAppendCategory) {
                    Color.black.opacity(0.5).ignoresSafeArea()
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 250, height: 250)
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 0.25, x: 0.2, y: 0.2)
                        .overlay(
                            VStack {
                                HStack {
                                    Button(action: {
                                        isAppendCategory = false
                                        appendResult = false
                                    }) {
                                        Image(systemName: "xmark")
                                            .foregroundColor(.black)
                                    }
                                    
                                    Spacer()
                                }
                                .padding(4)
                                
                                Text(appendResult ? appendResultMsg : "추가하실 카테고리를 입력해주세요.")
                                    .multilineTextAlignment(.center)
                                    .font(.title2)
                                
                                Spacer()
                                
                                TextField("", text: $categoryName)
                                Divider()
                                
                                Spacer()
                                
                                Button(action: handleCreateNewCategory) {
                                    Text("카테고리 추가")
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 45)
                                        .background(Color.black)
                                        .cornerRadius(10)
                                }
                                
                            }
                            .padding()
                        )
                        .transition(.opacity)
                }
            }
            .alert(isPresented: $isLogout) {
                Alert(
                    title: Text("로그아웃 하실건가요?"),
                    primaryButton: .default(Text("로그아웃"), action: {
                        handleLogout()
                    }),
                    secondaryButton: .default(Text("취소"))
                )
            }
            .navigationBarHidden(true)
        }
    }
    
    // MARK: 카테고리 생성 함수
    func handleCreateNewCategory() {
        if (categoryName == "") {
            appendResultMsg = "카테고리 이름을 입력해주세요!"
            appendResult = true
            return
        }
        
        CategoryApi().createNewCategory(appModel.email, categoryName) { status, msg, categoryName in
            if (!status) {
                appendResultMsg = "카테고리를 추가하는데 실패했어요. \n 다시 시도해주세요!"
                appendResult = true
                return
            }
            
            DispatchQueue.main.async {
                isAppendCategory = false
                appModel.categoryList.append(categoryName)
                UINotificationFeedbackGenerator().notificationOccurred(.success)
            }
        }
    }
    
    // MARK: 로그아웃
    func handleLogout() {
        viewContext.delete(loginState[0])
        
        do {
            try viewContext.save()
            
            DispatchQueue.main.async {
                appModel.email = ""
                appModel.name = ""
                appModel.isLogin = false
            }
            
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(AppModel())
    }
}
