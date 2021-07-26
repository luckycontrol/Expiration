//
//  MainView.swift
//  Expiration
//
//  Created by 조종운 on 2021/05/12.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var appModel: AppModel
    
    @State private var products: [ResponseReadProduct] = []
    @State private var isLoading = false
    
    @State private var menu = false
    @State private var add = false
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
            List {
                ForEach(0 ..< 15) { _ in
                    if #available(iOS 15.0, *) {
                        Card()
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(action: {}) {
                                    Label("삭제", systemImage: "trash")
                                }
                                .tint(.red)
                                
                                Button(action: {}) {
                                    Label("수정", systemImage: "hammer")
                                }
                                .tint(.yellow)
                            }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationBarTitle(appModel.selectedCateogry)
            .navigationBarHidden(menu ? true : false)
            .navigationBarItems(leading:
                                    Button(action: { menu.toggle() }) { Image(systemName: "list.bullet") }
                                    .buttonStyle(PlainButtonStyle())
            )
            .navigationBarItems(trailing:
                                    HStack {
                Button(action: { add.toggle() }) {
                    Image(systemName: "plus")
                }
                .buttonStyle(PlainButtonStyle())
            })
            
            if menu {
                Menu(menu: $menu)
            }
            
            NavigationLink(destination: Add(), isActive: $add) { EmptyView() }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            MainView()
        }
        .environmentObject(AppModel())
        .preferredColorScheme(.light)
    }
}
