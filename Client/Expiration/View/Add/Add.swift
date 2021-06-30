//
//  Add.swift
//  Expiration
//
//  Created by 조종운 on 2021/05/13.
//

import SwiftUI

struct Add: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var appModel: AppModel
    
    @State private var name = ""
    @State private var expiration = Date()
    @State private var image: UIImage?
    
    @State private var insertImage = false
    @State private var openImagePicker = false
    @State private var sourceType: UIImagePickerController.SourceType?
    @State private var addResult = ""
    @State private var addAlert = false
    
    var body: some View {
        let insertActionSheet = ActionSheet(
            title: Text("사진을 추가해주세요."),
            message: Text("어떤 방식으로 추가하실건가요?"),
            buttons: [
                .default(Text("카메라로 직접 촬영")) {
                    sourceType = .camera
                    openImagePicker = true
                },
                .default(Text("앨범에서 선택")) {
                    sourceType = .photoLibrary
                    openImagePicker = true
                },
                .cancel(Text("취소"))
            ]
        )
        
        let insertAlert = Alert(
            title: Text(addResult),
            message: Text("다시 한 번 시도해주세요."),
            dismissButton: Alert.Button.cancel(Text("확인"))
        )
        
        VStack(alignment: .leading) {
            if image != nil {
                Image(uiImage: image!)
                    .resizable()
                    .frame(height: 300)
                    .scaledToFit()
                    .onTapGesture {
                        insertImage = true
                    }
                    .actionSheet(isPresented: $insertImage) {
                        insertActionSheet
                    }
            } else {
                Rectangle()
                    .frame(height: 300)
                    .foregroundColor(.black.opacity(0.1))
                    .overlay(
                        ZStack(alignment: .center) {
                            VStack {
                                Image(systemName: "photo.fill")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .scaledToFit()
                                
                                Text("\(appModel.selectedCateogry) 이미지를 넣어주세요.")
                                    .fontWeight(.medium)
                                    .padding(.top, 8)
                            }
                        }
                    )
                    .onTapGesture {
                        insertImage = true
                    }
                    .actionSheet(isPresented: $insertImage) {
                        insertActionSheet
                    }
            }
            
            VStack(spacing: 20) {
                VStack(alignment: .leading) {
                    Text("이름")
                        .font(.body)
                        .fontWeight(.medium)
                    
                    TextField("", text: $name)
                        .padding(.horizontal)
                        .frame(height: 40)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: .primary.opacity(0.1), radius: 2, x: 2, y: 2)
                        .shadow(color: .primary.opacity(0.1), radius: 2, x: -2, y: -2)
                }
                
                VStack(alignment: .leading) {
                    Text("유통기한")
                        .font(.body)
                        .fontWeight(.medium)
                    DatePicker("", selection: $expiration, in: Date()..., displayedComponents: .date)
                }
            }
            .padding(.top, 30)
            
            
            Spacer()
            
            Button(action: {
                add()
                
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("\(appModel.selectedCateogry) 추가")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(Color("MenuColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
        .navigationBarTitle("\(appModel.selectedCateogry) 추가")
        .padding()
        .fullScreenCover(isPresented: $openImagePicker) {
            Camera(sourceType: sourceType, selectedImage: $image)
        }
        .alert(isPresented: $addAlert) { insertAlert }
    }
    
    func itemCheck() {
        
    }
    
    // 추가
    func add() {
        let encodedImage = imageEncoding(image!)
        let expiration = changeExpiration(expiration)
        let newProduct = createProductObject(encodedImage, expiration)
        
        ProductApi().createProduct(newProduct) { result in
            addResult = result
        }
    }
    
    // 이미지 인코딩
    func imageEncoding(_ image: UIImage) -> String {
        let imgData = image.jpegData(compressionQuality: 1.0)
        return (imgData?.base64EncodedString())!
    }
    
    // 바디에 넣을 오브젝트 생성
    func createProductObject(_ encodedImage: String, _ expiration: String) -> RequestCreateProduct {
        let newProduct = RequestCreateProduct(
            productCategory: appModel.selectedCateogry,
            productName: name,
            productImage: encodedImage,
            expiration: expiration,
            username: "luckycontrol"
        )
        
        return newProduct
    }
    
    // 날짜 Date -> String
    func changeExpiration(_ expiration: Date) -> String {
        let dateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy년 MM월 dd일"
            return dateFormatter
        }()
        
        return dateFormatter.string(from: expiration)
    }
}

struct Add_Previews: PreviewProvider {
    
    static let appModel = AppModel()
    
    static var previews: some View {
        NavigationView {
            Add(appModel: appModel)
        }
    }
}
