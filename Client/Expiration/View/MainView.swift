//
//  MainView.swift
//  Expiration
//
//  Created by 조종운 on 2021/05/12.
//

import SwiftUI

struct MainView: View {
    @StateObject var appModel = AppModel()
    
    let columns = [
        GridItem(.flexible()),
    ]
    
    @State private var menu = false
    @State private var edit = false
    @State private var changeOrderWay = false
    @State private var offset: CGSize = .zero
    
    var formatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        return dateFormatter
    }()
    
    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                
                // MARK: 메뉴, 도움말, 플러스
                HStack {
                    Button(action: {
                        menu = true
                    }) {
                        Image(systemName: "list.bullet")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                    Spacer()
                    
                    HStack(spacing: 15) {
                        Image(systemName: "questionmark")
                            .font(.title2)
                        
                        NavigationLink(destination: Add(appModel: appModel)) {
                            Image(systemName: "plus")
                                .font(.title2)
                                .foregroundColor(.primary)
                        }
                    }
                }
                .padding([.horizontal, .bottom])
                
                // MARK: 선택 카테고리
                HStack {
                    Text(appModel.selectedCateogry)
                        .font(.title)
                        .fontWeight(.black)
                    Spacer()
                }
                .padding(.horizontal)
                
                // MARK: 편집, 정렬방식
                HStack {
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 8) {
                        Button(action: {
                            withAnimation(.linear(duration: 0.15)) {
                                edit.toggle()
                            }
                        }) {
                            Text("편집")
                                .font(.headline)
                                .foregroundColor(.secondary)
                        }
                        
                        Button(action: { changeOrderWay = true }) {
                            Text("정렬 방식: \(appModel.selectedOrderWay)")
                                .font(.headline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding(.horizontal)
                
                // MARK: 저장된 데이터 출력
                
            }
            .background(Color.primary.opacity(0.01).edgesIgnoringSafeArea(.all))
            .blur(radius: menu ? 3 : 0)
            .actionSheet(isPresented: $changeOrderWay) {
                ActionSheet(
                    title: Text("정렬 방식을 변경합니다."),
                    message: Text("원하시는 방식을 선택해주세요."),
                    buttons: [
                        .default(Text("유통기한 순")) { },
                        .default(Text("이름 순")) { },
                        .cancel(Text("취소"))
                    ]
                )
            }
            
            Menu(appModel: appModel, menu: $menu)
                .offset(x: menu ? 0 : -UIScreen.main.bounds.width)
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
    
    // MARK: 데이터 삭제 함수
    func deleteItem() {
        
    }
}


let test = [
    Category(name: "사과", category: "음식", expiration: Date()),
    Category(name: "사과", category: "음식", expiration: Date()),
    Category(name: "사과", category: "음식", expiration: Date()),
    Category(name: "사과", category: "음식", expiration: Date()),
    Category(name: "사과", category: "음식", expiration: Date()),
    Category(name: "사과", category: "음식", expiration: Date())
]

struct MainView_Previews: PreviewProvider {
    
    static let appModel = AppModel()
    
    static var previews: some View {
        NavigationView {
            MainView(appModel: appModel)
        }
        .preferredColorScheme(.light)
    }
}
