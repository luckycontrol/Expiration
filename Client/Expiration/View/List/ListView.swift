//
//  MainView.swift
//  Expiration
//
//  Created by 조종운 on 2021/05/12.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var appModel: AppModel

    @State private var isLoading = false
    
    @Binding var menu: Bool
    @State private var add = false
    @State private var edit = false
    @State private var changeOrderWay = false
    @State private var offset: CGSize = .zero
    
    @State private var selectedProduct: ProductStructure?
    
    @State private var removeAlert: Bool = false
    
    var formatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        return dateFormatter
    }()
    
    var body: some View {
        ZStack {
            Rectangle()
                .overlay(
                    VStack {
                        // MARK: 상단 메뉴
                        HStack {
                            Button(action: {
                                withAnimation {
                                    UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                                    menu.toggle()
                                }
                            }) {
                                Image(systemName: "list.bullet")
                                    .resizable()
                                    .frame(width: 25, height: 20)
                            }
                        
                            Spacer()
                            
                            Text(appModel.selectedCateogry)
                                .font(.title2)
                            
                            Spacer()
                        
                            Button(action: {
                                UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                                add = true
                            }) {
                                Image(systemName: "plus")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                        }
                        .padding(.top, 60)
                        .padding([.horizontal, .bottom], 30)
                        
                        // MARK: 리스트
                        List {
                            ForEach(appModel.productList, id: \._id) { product in
                                if #available(iOS 15.0, *) {
                                    Card(product)
                                        .swipeActions(edge: .trailing) {
                                            Button(action: {
                                                handleRemoveProduct(product)
                                            }) {
                                                Text("삭제")
                                            }
                                            .tint(.red)

                                            Button(action: {
                                                selectedProduct = product
                                                edit = true
                                                UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                                            }) {
                                                Text("수정")
                                            }
                                            .tint(.yellow)
                                        }
                                }
                            }
                        }
                        .listStyle(.inset)
                    }
                    .foregroundColor(.black)
                )
                .cornerRadius(menu ? 25 : 0)
                .scaleEffect(menu ? 0.8 : 1)
                .offset(x: menu ? 200 : 0)
                .foregroundColor(.white).ignoresSafeArea()
                .onAppear(perform: fetchProduct)
            
            NavigationLink(destination: Add(), isActive: $add) { EmptyView() }
            
            if (edit) {
                NavigationLink(destination: Edit(product: selectedProduct!), isActive: $edit) { EmptyView() }
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
    
    func handleRemoveProduct(_ product: ProductStructure) {
        ProductApi().removeProduct(product.email, product._id) { status in
            DispatchQueue.main.async {
                appModel.productList = appModel.productList.filter { i in i._id != product._id }
                removeImageInDocument(product.image)
                UINotificationFeedbackGenerator().notificationOccurred(.success)
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            ListView(menu: .constant(false))
        }
        .environmentObject(AppModel())
        .preferredColorScheme(.light)
    }
}


//HStack {
//    Button(action: {
//        withAnimation {
//            menu.toggle()
//        }
//    }) {
//        Image(systemName: "list.bullet")
//            .resizable()
//            .frame(width: 25, height: 20)
//    }
//
//    Spacer()
//
//    Button(action: {}) {
//        Image(systemName: "plus")
//            .resizable()
//            .frame(width: 20, height: 20)
//    }
//}
