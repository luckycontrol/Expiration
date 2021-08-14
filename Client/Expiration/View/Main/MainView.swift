//
//  MainView.swift
//  Expiration
//
//  Created by 조종운 on 2021/05/12.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var appModel: AppModel

    @State private var isLoading = false
    
    @State private var menu = false
    @State private var add = false
    @State private var edit = false
    @State private var changeOrderWay = false
    @State private var offset: CGSize = .zero
    
    @State private var selectedProduct: ProductStructure? = nil
    
    var formatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        return dateFormatter
    }()
    
    var body: some View {
        ZStack {
            List {
                ForEach(appModel.productList, id: \._id) { product in
                    if #available(iOS 15.0, *) {
                        Card(product)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(action: {}) {
                                    Label("삭제", systemImage: "trash")
                                }
                                .tint(.red)
                                
                                Button(action: {
                                    selectedProduct = product
                                    edit = true
                                }) {
                                    Label("수정", systemImage: "")
                                }
                                .tint(.yellow)
                            }
                    }
                }
            }
            .onAppear(perform: fetchProduct)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle(appModel.selectedCateogry)
            .navigationBarHidden(menu ? true : false)
            .navigationBarItems(
                leading: Button(action: {
                    UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                    menu.toggle()
                }) {
                    Image(systemName: "list.bullet")
                }
                .buttonStyle(.plain)
            )
            .navigationBarItems(
                trailing: HStack {
                    Button(action: {
                        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                        add.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                    .buttonStyle(.plain)
                }
            )
            
            if menu {
                Menu(menu: $menu)
            }
            
            NavigationLink(destination: Add(), isActive: $add) { EmptyView() }
            if (selectedProduct != nil) {
                NavigationLink(destination: Edit(selectedProduct!), isActive: $edit) { EmptyView() }
            }
        }
    }
    
    func fetchProduct() {
        isLoading = true
        
        ProductApi().getProductList(appModel.email, appModel.selectedCateogry) { productList in
            DispatchQueue.main.async {
                appModel.productList = productList
                
                isLoading = false
            }
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
